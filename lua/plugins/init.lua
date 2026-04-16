
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

    "https://github.com/neovim/nvim-lspconfig",                    -- lsp server configurations
    "https://github.com/williamboman/mason.nvim",                  -- installs language servers
    "https://github.com/L3MON4D3/LuaSnip",                         -- snippets
    "https://github.com/Saghen/blink.cmp",                         -- completition

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
      bullets = { "◉", "○", "✸", "✿" },
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

require("nvim-treesitter").setup( {
           ensure_installed = {    -- keep query else errors in this file for headlines
               "c", "cpp", "vim", "vimdoc", "lua", "css", "html", "make", "bash",
               "yaml", "java", "json", "cmake", "fortran", "julia", "python",
               "bibtex", "markdown", "typescript", "dockerfile", "query" },
           highlight = { enable = true }
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
                 ["cmake-language-server"] = "cmake",
             }

for srv, _ in pairs(servers) do
    _ = require("mason-registry").is_installed(srv) or vim.cmd("MasonInstall " .. srv)
end

--===================== luasnip snippets

local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"
require("luasnip.loaders.from_vscode").lazy_load( { paths = snippets_path })

--===================== blink completion

require("blink.cmp").setup({

    fuzzy = { implementation = "lua" },
    snippets = { preset = 'luasnip' },
    keymap = {                      -- https://cmp.saghen.dev/configuration/keymap.html
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then return cmp.accept()
                else return cmp.select_and_accept() end
            end,
            'snippet_forward',
            'fallback'
        },
    },
})
----------------------------------------

local capabilities = require('blink.cmp').get_lsp_capabilities()

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
    max_width = 100,
    max_height = 12,
    max_width_window_percentage = math.huge,
    max_height_window_percentage = math.huge,
    window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
})

--===================== molten run code blocks

vim.schedule(function()              -- delays running till UpdateRemotePlugins exists; error otherwise
    vim.cmd("silent! UpdateRemotePlugins")   -- run this on installation (but here, always done; tried some fancy stuff to only run on install, but way slower)
end)                                         -- silent! suppresses the message about making a manifest

vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_win_max_height = 20

vim.g.molten_virt_text_output = true
vim.g.molten_image_location = "both"
vim.g.molten_auto_open_output = false

--===================== otter (for quarto)

require("plugins.patch.ensure_otter_patch").ensure_otter_patch()          -- apply bug fix to keep otter from breaking
require("otter").setup( { buffers = { set_filetype = true }, })   -- it has several issues but fixed with quarto settings below (diagnostics, completion off; languages explicitly set)

--===================== quarto

require("quarto").setup({
    lspFeatures = {
        diagnostics = { enabled = false },
        completion  = { enabled = false },
        languages   = { "python", "julia" },
    },
})
