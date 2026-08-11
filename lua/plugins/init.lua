
-- update via :lua vim.pack.update()

--=============================================================================
-- code for treesitter: to call TSUpdate on update; has to come before vim.pack.add

vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

--=============================================================================
-- install the plugins

vim.pack.add({
    "https://github.com/BYUignite/forsake-repent",                 -- colormap
    "https://github.com/nvim-tree/nvim-web-devicons",              -- for file icons for barbar, telescope, etc.
    "https://github.com/romgrk/barbar.nvim",                       -- buffer tabs at top

    "https://github.com/alexghergh/nvim-tmux-navigation",          -- seemless integration with tmux
    "https://github.com/karb94/neoscroll.nvim",                    -- smooth scrolling
    "https://github.com/0x00-ketsu/maximizer.nvim",                -- maximize current window split
    "https://github.com/kassio/neoterm",                           -- open/close terminal easily; positioning
    "https://github.com/max397574/better-escape.nvim",             -- escape from terminal

    "https://github.com/derektata/lorem.nvim",                     -- lorem-ipsum: just type loremX inline in insert mode to get X words
    "https://github.com/brenoprata10/nvim-highlight-colors",       -- show colors for color codes
    "https://github.com/vim-scripts/a.vim",                        -- switch between header and source
    "https://github.com/lervag/vimtex",                            -- latex tools
    "https://github.com/iamcco/markdown-preview.nvim",             -- <leader>v to preview markdown files in browser
    "https://github.com/lukas-reineke/headlines.nvim",             -- format markdown and quarto
    "https://github.com/tpope/vim-fugitive",                       -- git stuff
    "https://github.com/lewis6991/gitsigns.nvim",                  -- indicate git changes in left column
    "https://github.com/windwp/nvim-autopairs",                    -- auto pairing of (), [], etc.
    "https://github.com/nvim-treesitter/nvim-treesitter",          -- treesitter!

    "https://github.com/nvim-lua/plenary.nvim",                    -- helpers needed for other plugins
    "https://github.com/mikavilpas/yazi.nvim",                     -- file manager (needs plenary)
    "https://github.com/nvim-telescope/telescope.nvim",            -- find files, grep, etc. (needs plenary)
    --"https://github.com/dmtrKovalenko/fff.nvim",

    "https://github.com/neovim/nvim-lspconfig",                    -- lsp server configurations
    "https://github.com/williamboman/mason.nvim",                  -- installs language servers
    "https://github.com/L3MON4D3/LuaSnip",                         -- snippets

    "https://github.com/hrsh7th/nvim-cmp",                         -- completion
    "https://github.com/hrsh7th/cmp-nvim-lsp",                     -- LSP completion source
    "https://github.com/hrsh7th/cmp-buffer",                       -- buffer completion source
    "https://github.com/hrsh7th/cmp-path",                         -- path completion source
    "https://github.com/saadparwaiz1/cmp_luasnip",                 -- LuaSnip completion source

    "https://github.com/vhyrro/luarocks.nvim",                     -- for running code in quarto/markdown cells
    "https://github.com/3rd/image.nvim",                           -- for running code in quarto/markdown cells
    "https://github.com/benlubas/molten-nvim",                     -- for running code in quarto/markdown cells
    "https://github.com/benlubas/otter.nvim",                        -- for running code in quarto/markdown cells
    "https://github.com/quarto-dev/quarto-nvim",                   -- for running code in quarto/markdown cells
})
--=============================================================================
-- setup/configure plugins

--===================== forsake-repent colorscheme
-- no config needed

--===================== nvim-web-devicons (for barbar)
-- no config needed


--===================== barbar

require("barbar").setup( { icons = {filetype = {custom_colors=true, enabled=true}} } )
vim.g.barbar_auto_setup = false

--===================== nvim-tmux-navigation

require("nvim-tmux-navigation").setup({ disable_when_zoomed = true })

--===================== neoscroll

require("neoscroll").setup( { duration_multiplier = 0.75, hide_cursor = false } )

--===================== maximizer

require("maximizer").setup( {} )

--===================== neoterm

vim.g.neoterm_default_mod = 'belowright'
vim.g.neoterm_autoinsert = 1
vim.g.neoterm_size = 20

--===================== better-escape

require("better_escape").setup( { mappings = { i = { j = { k = false, }, } } } )

--===================== lorem

require("lorem").opts( {} )

--===================== nvim-highlight-colors

require("nvim-highlight-colors").setup({})

--===================== a
-- no config needed

--===================== vimtex

vim.g.vimtex_view_method = 'skim'
vim.g.tex_flavor = 'latex'
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
vim.g.vimtex_compiler_progname = 'nvr'

--===================== markdown preview

vim.fn["mkdp#util#install"]()

--===================== headlines

require('headlines').setup({
  quarto = {
      dash_string = "⚯",
      headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4" },
      query = vim.treesitter.query.parse(
          'markdown', 
          [[
          (atx_heading [
          (atx_h1_marker)
          (atx_h2_marker)
          (atx_h3_marker)
          (atx_h4_marker)
          (atx_h5_marker)
          (atx_h6_marker)
          ] @headline)
          (thematic_break) @dash
          (fenced_code_block) @codeblock
          (block_quote_marker) @quote
          (block_quote (paragraph (inline (block_continuation) @quote)))
          (block_quote (paragraph (block_continuation) @quote))
          (block_quote (block_continuation) @quote)
          ]]
      ),
      bullet_highlights = {
          "@text.title.1.marker.markdown",
          "@text.title.2.marker.markdown",
          "@text.title.3.marker.markdown",
          "@text.title.4.marker.markdown",
          "@text.title.5.marker.markdown",
          "@text.title.6.marker.markdown",
      },

      bullets = { "◘", "●", "■", "◆" },
      codeblock_highlight = "CodeBlock",
      dash_highlight = "Dash",
      dash_string = "-",
      quote_highlight = "Quote",
      quote_string = "┃",
      fat_headlines = true,
      fat_headline_lower_string = "▀",
      fat_headline_upper_string = "▄",
      treesitter_language = 'markdown',
  },
  markdown = {                      -- use defaults with changes here
      dash_string = "⚯",
      headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4" },
  },
})

--===================== vim-fugitive
-- no config needed

--===================== gitsigns

require("gitsigns").setup( )

--===================== autopairs for (), [], etc.
-- todo: update for completion (cmp) if needed

require("nvim-autopairs").setup( { fast_wrap = {},  ignored_next_char = "[%w%.]" } )

--===================== treesitter

local treesitter_languages = {    -- keep query else errors in this file for headlines
    "c", "cpp", "vim", "vimdoc", "lua", "css", "html", "make", "bash",
    "yaml", "java", "json", "cmake", "fortran", "julia", "python",
    "bibtex", "markdown", "markdown_inline", "typescript", "dockerfile", "query"
}

require("nvim-treesitter").setup()
require("nvim-treesitter").install(treesitter_languages)


vim.api.nvim_create_autocmd("FileType", {
    pattern = vim.list_extend(vim.deepcopy(treesitter_languages), { "quarto" }),
    callback = function(args)
        if args.match == "quarto" then
            vim.treesitter.language.register("markdown", "quarto")
        end
        pcall(vim.treesitter.start, args.buf)
    end,
})

--===================== plenary
-- no config needed

--===================== yazi file manager
-- no config needed

--===================== telescope

local root_patterns = { ".git" } -- Add or modify based on your project structure
local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

require("telescope").setup( {
   pickers = {
       live_grep = {
           file_ignore_patterns = { 'node_modules', '.git', '.cpcache', '.clj-kondo', '.lsp' }, -- Customize ignore patterns
           search_dirs = { root_dir },
       },
   },
})

--===================== fff

-- vim.api.nvim_create_autocmd('PackChanged', {
--   callback = function(ev)
--     local name, kind = ev.data.spec.name, ev.data.kind
--     if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
--       if not ev.data.active then vim.cmd.packadd('fff.nvim') end
--       require('fff.download').download_or_build_binary()
--     end
--   end,
-- })

--===================== lspconfig
-- no config needed

--===================== mason

require("mason").setup({
    ui = { icons = { package_installed = "✓",
                     package_pending = "➜",
                     package_uninstalled = "✗"
         } }
})

local servers = {["clangd"]                = "clangd",                -- first is external package name; second is nvim-lspconfig server name
                 ["fortls"]                = "fortls",
                 ["jedi-language-server"]  = "jedi_language_server",
                 ["julia-lsp"]             = "julials",
                 ["marksman"]              = "marksman",
                 ["texlab"]                = "texlab",
                 ["lua-language-server"]   = "lua_ls",
             }

for srv, _ in pairs(servers) do
    _ = require("mason-registry").is_installed(srv) or vim.cmd("MasonInstall " .. srv)
end

--===================== luasnip snippets

local luasnip = require("luasnip")
local luasnip_ft = require("luasnip.extras.filetype_functions")

---------------

local function parse_code_fence(line)
    local ticks, tick_info = line:match("^%s*(```+)%s*(.*)$")
    if ticks then
        return "`", #ticks, tick_info
    end

    local tildes, tilde_info = line:match("^%s*(~~~+)%s*(.*)$")
    if tildes then
        return "~", #tildes, tilde_info
    end
end

---------------

local function code_cell_filetype(info_string)
    local lang = info_string:match("^%s*{%s*%.?([%w_+-]+)")
        or info_string:match("^%s*([%w_+-]+)")

    if not lang then
        return nil
    end

    lang = lang:lower()

    local aliases = {
        py  = "python",
        jl  = "julia",
        pyi = "pyodide",
    }

    return aliases[lang] or lang
end

---------------

local function current_code_cell_filetype()
    local row = vim.api.nvim_win_get_cursor(0)[1]

    if parse_code_fence(vim.api.nvim_get_current_line()) then
        return nil
    end

    local lines = vim.api.nvim_buf_get_lines(0, 0, math.max(row - 1, 0), false)
    local in_fence = false
    local opening_fence_char = nil
    local opening_fence_len = 0
    local cell_ft = nil

    for _, line in ipairs(lines) do
        local fence_char, fence_len, fence_info = parse_code_fence(line)

        if fence_char then
            if in_fence then
                if fence_char == opening_fence_char and fence_len >= opening_fence_len then
                    in_fence = false
                    opening_fence_char = nil
                    opening_fence_len = 0
                    cell_ft = nil
                end
            else
                in_fence = true
                opening_fence_char = fence_char
                opening_fence_len = fence_len
                cell_ft = code_cell_filetype(fence_info)
            end
        end
    end

    if in_fence then
        return cell_ft
    end
end

---------------

local function is_quarto_like_filetype(fts)
    return vim.tbl_contains(fts, "quarto") or vim.tbl_contains(fts, "markdown")
end

---------------

luasnip.setup({
    ft_func = function()
        local fts = luasnip_ft.from_filetype()

        if is_quarto_like_filetype(fts) then
            local cell_ft = current_code_cell_filetype()
            if cell_ft then
                return { cell_ft }
            end
        end

        return fts
    end,
    load_ft_func = function(bufnr)
        local fts = luasnip_ft.from_filetype_load(bufnr)

        if is_quarto_like_filetype(fts) then
            vim.list_extend(fts, { "python", "julia", "pyodide" })
        end

        return fts
    end,
})

local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"
require("luasnip.loaders.from_vscode").lazy_load( { paths = snippets_path })

--===================== nvim-cmp completion

vim.o.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")

cmp.setup({
    preselect = cmp.PreselectMode.Item,
    completion = {
        completeopt = "menu,menuone",
    },
    performance = {
        max_view_entries = 10,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, item)
            local max_width = 40
            if #item.abbr > max_width then
                item.abbr = item.abbr:sub(1, max_width - 1) .. "…"
            end

            local source_names = {
                otter = "[cell]",
                nvim_lsp = "[lsp]",
                luasnip = "[snip]",
                path = "[path]",
                buffer = "[buf]",
            }
            item.menu = source_names[entry.source.name] or ("[" .. entry.source.name .. "]")
            return item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.config.disable,
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if cmp.get_selected_entry() == nil then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
                cmp.confirm({ select = true })
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "otter" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.filetype({ "quarto" }, {
    sources = cmp.config.sources({
        { name = "otter" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
})

----------------------------------------

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, srv in pairs(servers) do
    vim.lsp.config(srv, {capabilities = capabilities,} )
    vim.lsp.enable(srv)
end

--=============================================================================
--=============================================================================
--=============================================================================

--===================== luarocks (for python quarto)

require("luarocks-nvim").setup({ opts = { rocks = { 'magick' } } })

--===================== image (for python quarto)

require("image").setup({ 
    integrations = { markdown = { filetypes = { "markdown", "vimwiki", "quarto" }, }, },
    max_width = 200,
    max_height = 20 ,
    max_width_window_percentage = math.huge,
    max_height_window_percentage = math.huge,
    window_overlap_clear_enabled = false,
})

--===================== molten run code blocks

require("plugins.patch.ensure_molten_patch").ensure_molten_patch()

vim.schedule(function()              -- delays running till UpdateRemotePlugins exists; error otherwise
    vim.cmd("silent! UpdateRemotePlugins")   -- run this on installation (but here, always done; tried some fancy stuff to only run on install, but way slower)
end)                                         -- silent! suppresses the message about making a manifest

vim.g.molten_virt_text_max_lines      = 8
vim.g.molten_output_win_max_height    = 20
vim.g.molten_output_win_max_width     = 200
vim.g.molten_virt_text_output         = true
vim.g.molten_virt_lines_off_by_1      = true
vim.g.molten_auto_open_output         = false
vim.g.molten_enter_output_behavior    = "open_and_enter"  -- (not open_then_enter); call using :noautocmd MoltenEnterOutput
vim.g.molten_output_win_hide_on_leave = false
vim.g.molten_image_provider           = "image.nvim"
vim.g.molten_image_location           = "virt"

--===================== otter (for quarto)

require("plugins.patch.ensure_otter_patch").ensure_otter_patch()          -- apply bug fix to keep otter from breaking
require("otter").setup({
    buffers = {
        set_filetype = true,
        write_to_disk = false,
    },
})   -- keep otter buffers in-memory; on-disk temp files are only needed for some file-backed tools
do   -- codex added this to fix a bug (my installed otter.nvim no longer exposes rafts, it uses _otters_attached instead...)
    local otterkeeper = require("otter.keeper")
    if otterkeeper.rafts == nil and otterkeeper._otters_attached ~= nil then
        otterkeeper.rafts = otterkeeper._otters_attached
    end
end

--===================== quarto

require("quarto").setup({
    lspFeatures = {
        diagnostics = { enabled = false },
        completion  = { enabled = true },
        languages   = { "python", "julia" },
    },
    codeRunner = {
        enabled = true,
        default_method = "molten",
    },
})
