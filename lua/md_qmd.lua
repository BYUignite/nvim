
--- Setup quarto and markdown files so that if the frontmatter has:
--- code: python, then run :MoltenInit and choose the first python kernel
--- code: julia,  then run :MoltenInit and choose the first julia kernel
--- Set keymaps for md and qmd files: 
---    <leader>r to run a cell
---    <leader>ra to run all cells
---    <leader>rs to run cells from start to current
---    <leader>v to run markdown or quarto preview (in the browser)

-------------------------------------------------------------------------------

local M = {}

local function init_with_first_kernel_then(buf, kernel_filter, callback)

    if require("molten.status").initialized() ~= "" then
        callback()
        return
    end

    local kernels = vim.fn.MoltenAvailableKernels()
    local first_kernel = nil

    if kernels ~= nil then
        for _, kernel in ipairs(kernels) do
            if kernel_filter == nil or kernel:lower():match(kernel_filter) then
                first_kernel = kernel
                break
            end
        end
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenKernelReady",
        once = true,
        callback = function()
            if vim.api.nvim_buf_is_valid(buf) then
                callback()
            end
        end,
    })

    if first_kernel ~= nil and first_kernel ~= "" then
        vim.cmd(("MoltenInit %s"):format(first_kernel))
    else
        vim.cmd("MoltenInit")
    end
end

-------------------------------------------------------------------------------

local function frontmatter_code_kernel_filter(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    if lines[1] ~= "---" then
        return nil
    end

    for i = 2, #lines do
        local line = lines[i]
        if line == "---" or line == "..." then
            return nil
        end
        local value = line:match([[^code:%s*['"]?([^'"]+)['"]?%s*$]])
        if value ~= nil then
            value = value:lower()
            if value == "python" then
                return "python"
            elseif value == "julia" then
                return "julia"
            else
                return nil
            end
        end
    end

    return nil
end

-------------------------------------------------------------------------------

function M.setup()
    local buf = vim.api.nvim_get_current_buf()
    local runner = require("quarto.runner")
    local function run_with_init(run_fn)
        return function()
            local kernel_filter = frontmatter_code_kernel_filter(buf)
            if kernel_filter ~= nil then
                init_with_first_kernel_then(buf, kernel_filter, run_fn)
            else
                run_fn()
            end
        end
    end

    vim.keymap.set("n", "<leader>r", run_with_init(runner.run_cell), {
        buffer = buf,
        silent = true,
        desc = "run cell",
    })
    vim.keymap.set("n", "<leader>rs", run_with_init(runner.run_above), {
        buffer = buf,
        silent = true,
        desc = "run start through current cell",
    })
    vim.keymap.set("n", "<leader>ra", run_with_init(runner.run_all), {
        buffer = buf,
        silent = true,
        desc = "run all cells",
    })
    vim.keymap.set("n", "<leader>q", "<cmd>MoltenInterrupt<CR>", {
        buffer = buf,
        silent = true,
        desc = "interrupt kernel",
    })
    vim.keymap.set("n", "gi", "<cmd>noautocmd MoltenEnterOutput<CR>", {
        buffer = buf,
        silent = true,
        desc = "enter output; us :q to leave the output",
    })

    local function get_line(line_nr)
        return vim.api.nvim_buf_get_lines(buf, line_nr - 1, line_nr, false)[1]
    end

    local function find_cell_from(start_line)
        local last = vim.api.nvim_buf_line_count(buf)

        for line_nr = math.max(start_line, 1), last do
            local line = get_line(line_nr)
            if line and line:match("^```%{") then
                for end_line_nr = line_nr + 1, last do
                    local end_line = get_line(end_line_nr)
                    if end_line and end_line:match("^```%s*$") then
                        return {
                            start_line = line_nr,
                            end_line = end_line_nr,
                        }
                    end
                end
                return nil
            end
        end

        return nil
    end

    local function find_current_cell(line_nr)
        local start_line = nil

        for scan_line = line_nr, 1, -1 do
            local line = get_line(scan_line)
            if line and line:match("^```%{") then
                start_line = scan_line
                break
            end
        end

        if start_line == nil then
            return nil
        end

        local cell = find_cell_from(start_line)
        if cell == nil then
            return nil
        end

        if cell.start_line < line_nr and line_nr < cell.end_line then
            return cell
        end

        return nil
    end

    local function target_line_for(cell)
        return math.max(cell.start_line, cell.end_line - 1)
    end

    local function find_previous_cell(before_line)
        local previous_cell = nil
        local search_line = 1

        while true do
            local cell = find_cell_from(search_line)
            if cell == nil or cell.start_line >= before_line then
                return previous_cell
            end

            previous_cell = cell
            search_line = cell.end_line + 1
        end
    end

    vim.keymap.set("n", "[", function()
        local current = vim.api.nvim_win_get_cursor(0)[1]
        local current_cell = find_current_cell(current)

        if current_cell ~= nil then
            if current == current_cell.end_line - 1 then
                local next_cell = find_cell_from(current_cell.end_line + 1)
                if next_cell ~= nil then
                    vim.api.nvim_win_set_cursor(0, { target_line_for(next_cell), 0 })
                end
                return
            end

            vim.api.nvim_win_set_cursor(0, { target_line_for(current_cell), 0 })
            return
        end

        local next_cell = find_cell_from(current + 1)
        if next_cell ~= nil then
            vim.api.nvim_win_set_cursor(0, { target_line_for(next_cell), 0 })
        end
    end, {
        buffer = buf,
        silent = true,
        desc = "move to next code cell",
    })
    vim.keymap.set("n", "]", function()
        local current = vim.api.nvim_win_get_cursor(0)[1]
        local current_cell = find_current_cell(current)

        if current_cell ~= nil then
            if current == current_cell.end_line - 1 then
                local previous_cell = find_previous_cell(current_cell.start_line)
                if previous_cell ~= nil then
                    vim.api.nvim_win_set_cursor(0, { target_line_for(previous_cell), 0 })
                end
                return
            end

            vim.api.nvim_win_set_cursor(0, { target_line_for(current_cell), 0 })
            return
        end

        local previous_cell = find_previous_cell(current)
        if previous_cell ~= nil then
            vim.api.nvim_win_set_cursor(0, { target_line_for(previous_cell), 0 })
        end
    end, {
        buffer = buf,
        silent = true,
        desc = "move to previous code cell",
    })
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

    local kernel_filter = frontmatter_code_kernel_filter(buf)
    if vim.b.molten_auto_init_done or kernel_filter == nil then
        return
    end

    vim.b.molten_auto_init_done = true
    vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
            init_with_first_kernel_then(buf, kernel_filter, function() end)
        end
    end)
end

return M
