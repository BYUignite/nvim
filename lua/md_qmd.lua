--- Setup markdown and quarto buffers for Molten.
--- If YAML frontmatter contains `code: python` or `code: julia`,
--- initialize Molten with the first matching kernel for that language.

local M = {}

local pending_inits = {}

--=============================================================================

local function parse_frontmatter_code(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    if lines[1] ~= "---" then
        return nil
    end

    for i = 2, #lines do
        local line = lines[i]
        if line == "---" or line == "..." then
            break
        end

        local value = line:match([[^code:%s*['"]?([^'"]+)['"]?%s*$]])
        if value ~= nil then
            value = value:lower()
            if value == "python" or value == "julia" then
                return value
            end
            return nil
        end
    end

    return nil
end

--=============================================================================

local function first_matching_kernel(language)
    local kernels = vim.fn.MoltenAvailableKernels()
    if type(kernels) ~= "table" then
        return nil
    end

    for _, kernel in ipairs(kernels) do
        if type(kernel) == "string" and kernel:lower():match(language) then
            return kernel
        end
    end

    return nil
end

--=============================================================================

local function with_ready_molten(buf, language, callback)
    local state = pending_inits[buf]
    if state == nil then
        state = {
            status = "idle",
            callbacks = {},
        }
        pending_inits[buf] = state
    end

    local molten_ok, molten_status = pcall(require, "molten.status")
    if molten_ok and molten_status.initialized() ~= "" then
        state.status = "ready"
        callback()
        return
    end

    if state.status == "starting" then
        table.insert(state.callbacks, callback)
        return
    end

    if state.status == "ready" then
        callback()
        return
    end

    state.status = "starting"
    state.callbacks = { callback }

    local kernel = first_matching_kernel(language)
    local ok, err

    if kernel ~= nil then
        ok, err = pcall(vim.cmd, ("MoltenInit %s"):format(kernel))
    else
        ok, err = pcall(vim.cmd, "MoltenInit")
    end

    if not ok then
        state.status = "idle"
        state.callbacks = {}
        vim.schedule(function()
            vim.notify(("MoltenInit failed: %s"):format(err), vim.log.levels.WARN)
        end)
        return
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenKernelReady",
        once = true,
        callback = function()
            local active_state = pending_inits[buf]
            if active_state ~= nil then
                active_state.status = "ready"
                local callbacks = active_state.callbacks
                active_state.callbacks = {}
                for _, queued_callback in ipairs(callbacks) do
                    queued_callback()
                end
            end
        end,
    })
end

--=============================================================================

local function get_line(buf, line_nr)
    return vim.api.nvim_buf_get_lines(buf, line_nr - 1, line_nr, false)[1]
end

--=============================================================================

local function current_code_cell(buf)
    local line_nr = vim.api.nvim_win_get_cursor(0)[1]
    local start_line = nil

    for scan = line_nr, 1, -1 do
        local line = get_line(buf, scan)
        if line ~= nil and line:match("^```%{") then
            start_line = scan
            break
        end
        if line ~= nil and line:match("^```%s*$") then
            return nil
        end
    end

    if start_line == nil then
        return nil
    end

    local last_line = vim.api.nvim_buf_line_count(buf)
    for scan = start_line + 1, last_line do
        local line = get_line(buf, scan)
        if line ~= nil and line:match("^```%s*$") then
            if start_line < line_nr and line_nr < scan then
                return {
                    start_line = start_line,
                    end_line = scan,
                }
            end
            return nil
        end
    end

    return nil
end

--=============================================================================

local function next_code_cell(buf, line_nr)
    local last_line = vim.api.nvim_buf_line_count(buf)

    for scan = math.max(line_nr, 1), last_line do
        local line = get_line(buf, scan)
        if line ~= nil and line:match("^```%{") then
            return {
                start_line = scan,
            }
        end
    end

    return nil
end

local function previous_code_cell(buf, line_nr)
    for scan = math.min(line_nr, vim.api.nvim_buf_line_count(buf)), 1, -1 do
        local line = get_line(buf, scan)
        if line ~= nil and line:match("^```%{") then
            return {
                start_line = scan,
            }
        end
    end

    return nil
end

--=============================================================================

function M.setup()
    local buf = vim.api.nvim_get_current_buf()
    local language = parse_frontmatter_code(buf)

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "<leader>v", function()
        if vim.bo.filetype == "markdown" then
            vim.cmd("MarkdownPreview")
        elseif vim.bo.filetype == "quarto" then
            vim.cmd("QuartoPreview")
        end
    end, {
        buffer = buf,
        silent = true,
        desc = "run view commands: markdown, quarto",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "<leader>q", "<cmd>MoltenInterrupt<CR>", {
        buffer = buf,
        silent = true,
        desc = "interrupt kernel",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "gi", "<cmd>noautocmd MoltenEnterOutput<CR>", {
        buffer = buf,
        silent = true,
        desc = "enter output; use :q to leave the output",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "<leader>r", function()
        local cell = current_code_cell(buf)
        if cell == nil then
            vim.notify("Cursor is not inside a code cell", vim.log.levels.WARN)
            return
        end

        local function run_cell()
            require("quarto.runner").run_cell()
            local next_cell = next_code_cell(buf, cell.end_line + 1)
            if next_cell ~= nil then
                vim.api.nvim_win_set_cursor(0, { next_cell.start_line + 2, 0 })
                return
            end

            vim.api.nvim_win_set_cursor(0, { cell.end_line - 2, 0 })
        end

        if language == nil then
            run_cell()
            return
        end

        with_ready_molten(buf, language, run_cell)
    end, {
        buffer = buf,
        silent = true,
        desc = "run current code cell",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "]]", function()
        local cell = current_code_cell(buf)
        if cell then
            vim.api.nvim_win_set_cursor(0, { cell.start_line + 2, 0 })
            return
        end

        vim.cmd("normal! ]]")
    end, {
        buffer = buf,
        silent = true,
        desc = "go to top of current code cell",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "[[", function()
        local cell = current_code_cell(buf)
        if cell then
            vim.api.nvim_win_set_cursor(0, { cell.end_line - 2, 0 })
            return
        end

        vim.cmd("normal! [[")
    end, {
        buffer = buf,
        silent = true,
        desc = "go to bottom of current code cell",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "[", function()
        local cell = current_code_cell(buf)
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        local target = nil

        if cell ~= nil then
            target = next_code_cell(buf, cell.end_line + 1)
        else
            target = next_code_cell(buf, current_line + 1)
        end

        if target ~= nil then
            vim.api.nvim_win_set_cursor(0, { target.start_line + 2, 0 })
        end
    end, {
        buffer = buf,
        silent = true,
        desc = "move to next code cell",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "]", function()
        local cell = current_code_cell(buf)
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        local target = nil

        if cell ~= nil then
            target = previous_code_cell(buf, cell.start_line - 1)
        else
            target = previous_code_cell(buf, current_line - 1)
        end

        if target ~= nil then
            vim.api.nvim_win_set_cursor(0, { target.start_line + 2, 0 })
        end
    end, {
        buffer = buf,
        silent = true,
        desc = "move to previous code cell",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim.keymap.set("n", "<leader>ra", function()
        local function run_all_cells()
            require("quarto.runner").run_all()
        end

        if language == nil then
            run_all_cells()
            return
        end

        with_ready_molten(buf, language, run_all_cells)
    end, {
        buffer = buf,
        silent = true,
        desc = "run all code cells",
    })

    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    if language == nil or vim.b.molten_auto_init_done then
        return
    end

    vim.b.molten_auto_init_done = true
    vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
            with_ready_molten(buf, language, function() end)
        end
    end)
end

return M
