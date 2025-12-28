-- See this link, gsinclair's answer for information on config and opts and how they are related:
-- https://neovim.discourse.group/t/different-ways-to-configure-plugins-through-lazy-vim-what-do-they-mean-and-which-one-do-i-use/4199/5
-- This is a good description of Lazy.nvim: https://dev.to/vonheikemen/lazynvim-plugin-configuration-3opi
-- Here's a link to the lazy plugin spec: https://lazy.folke.io/spec
-- Josean youtube video: https://www.youtube.com/watch?v=6mxWayq-s9I



--==============================================================================
--==============================================================================
------- bootstrap lazy.nvim to get it if it's not already here

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--==============================================================================
--==============================================================================

local plugins = {

    --==========================================================================
    {
        -- move between vim windows and tmux windows seemlessly (same command)
        "alexghergh/nvim-tmux-navigation",
        opts = { disable_when_zoomed = true }
    },
    --==========================================================================
    { 
        -- generate dummy text :Loremipsum or :Loremipsum 1000
        "vim-scripts/loremipsum",
        ft = {'markdown', 'text', 'tex', 'plaintex'}
    },
    --==========================================================================
    { 
        -- with multiple windows, allows toggling the current window to full size
        "szw/vim-maximizer",
        lazy = false,
    },
    --==========================================================================
    { 
        -- switch between header file and source file
        "vim-scripts/a.vim",
        lazy = false,
    },
    --==========================================================================
    {
        --smooth scrolling
        "karb94/neoscroll.nvim",
        opts = {
            duration_multiplier = 0.75,
            hide_cursor = false
        }
    },
    --==========================================================================
    { 
        -- easily open and close terminal
        "kassio/neoterm",
        init = function()
            --vim.g.neoterm_default_mod = 'botright'
            vim.g.neoterm_default_mod = 'belowright'
            vim.g.neoterm_autoinsert = 1
            vim.g.neoterm_size = 20
        end,
    },
    ----------------------------------------------------------------------------
    { 
        -- escpe from terminal
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup {
                mappings = { i = { j = { k = false, }, } }
            }
        end
    },
    --==========================================================================
    { 
        -- latex tools
        "lervag/vimtex",
        ft = { 'tex', 'plaintex' },
        config = function()
            vim.g.vimtex_view_method = 'skim'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
            vim.g.vimtex_compiler_progname = 'nvr'
        end
    },
    --==========================================================================
    {
        -- buffer tabs at top
        "romgrk/barbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons"}, -- OPTIONAL: for file icons
        init = function() vim.g.barbar_auto_setup = false end,
        opts = { icons = {filetype = {custom_colors=true, enabled=true}} },
        version = '^1.0.0',              -- OPTIONAL: only update when a new 1.x version is released
    },
    --==========================================================================
    { 
        -- show color of colorcodes: #587b7b
        "norcalli/nvim-colorizer.lua",
        config = true
    },
    ---------------------------------------------------------------------------
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- setup is called in config.lua
    },
    ---------------------------------------------------------------------------
    {
        -- custom color schemes
        "rktjmp/lush.nvim",
        lazy=true
    },
    ---------------------------------------------------------------------------
    {   -- repent scheme (local, so use dir)
        dir = vim.fn.stdpath("config") .. "/lua/themes/repent" ,  
        lazy=true
    },
    ---------------------------------------------------------------------------
    { 
        -- forsake scheme (local, so use dir)
        dir = vim.fn.stdpath("config") .. "/lua/themes/forsake" , 
        lazy=true 
    },
    --==========================================================================
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {    -- keep query else errors in this file for headlines
                "c", "cpp", "vim", "vimdoc", "lua", "css", "html", "make", "bash",
                "yaml", "java", "json", "cmake", "fortran", "julia", "python",
                "bibtex", "markdown", "typescript", "dockerfile", "query"
            },
            highlight = { enable = true }
        },
    },
    --==========================================================================
    {
        -- Git signs
        "lewis6991/gitsigns.nvim",
        config = true
    },
    ---------------------------------------------------------------------------
    {
        -- Git stuff
        "tpope/vim-fugitive",
    },
    --==========================================================================
    {
        -- telescope file finder etc.
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        --config = true
        config = function()
            local telescope = require("telescope")
            local root_patterns = { ".git" } -- Add or modify based on your project structure
            local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])

            telescope.setup({
                pickers = {
                    live_grep = {
                        file_ignore_patterns = { 'node_modules', '.git', '.cpcache', '.clj-kondo', '.lsp' }, -- Customize ignore patterns
                        search_dirs = { root_dir },
                    },
                },
            })
        end,
    },
    --==========================================================================
    {
        -- pair (), [], etc.
        "windwp/nvim-autopairs",
        opts = { fast_wrap = {}, },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    --==========================================================================
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        config = true,
        --keys = { { "<leader>e", "<cmd>Yazi<cr>", desc = "Open yazi at current file", }, }, -- done in ../keymaps.lua
    },
    --==========================================================================
    -- for images, markdown formatting, and running code (e.g. for qmd files)
    -- see video https://youtu.be/nYDMXI-yFTA for image.nvim installation (much easier than on the site)
    -- see video https://youtu.be/iNe88IZplYM?feature=shared for some inspiration, but using everything there
    -- was a waste of time. I ended up just with 
    -- headlines (formatting md, qmd), Molten (to run code cells), quarto (for visualizing in browser)
    -- and built my own keymap to go to markdown code cells and run them (see ../keymaps.lua)
    ---------------------------------------------------------------------------
    {
        -- for luarocks packages
        'vhyrro/luarocks.nvim',
        priority = 1001,
        opts = { rocks = { 'magick' } },
    },
    ---------------------------------------------------------------------------
    {
        -- images inside neovim (especially for quarto/code)
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        opts = {
            integrations = { markdown = { filetypes = { "markdown", "vimwiki", "quarto" }, }, },
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        },
    },
    ---------------------------------------------------------------------------
    {
        -- run code blocks in vim
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
    },
    ---------------------------------------------------------------------------
    {
        "quarto-dev/quarto-nvim",
        ft = { 'quarto' },
        enabled = true,
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    --==========================================================================
    { 
        -- preview markdown files
       "iamcco/markdown-preview.nvim",
       cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
       build = "cd app && yarn install",
       init = function() vim.g.mkdp_filetypes = { "markdown" } end,
       ft = { "markdown" },
    },
    ---------------------------------------------------------------------------
    {
       -- format markdown and quarto files inside vim
       "lukas-reineke/headlines.nvim",
       dependencies = "nvim-treesitter/nvim-treesitter",
       config = function() require('headlines').setup({
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
       end
    },
    --==========================================================================
    ------ LSP, Completion, Snippets
    ------ plugins loaded, but config completed in lsp.lua, called in ../../init.lua
    {
        -- mason will download and install lsp servers, see lsp.lua
        "williamboman/mason.nvim",
        opts = { 
            ui={ icons={ package_installed = "✓", 
                         package_pending = "➜", 
                         package_uninstalled = "✗" } }
        }
    },
    ---------------------------------------------------------------------------
    { 
        -- lsp configuration for each server
        "neovim/nvim-lspconfig" 
    },
    ---------------------------------------------------------------------------
    { 
        -- completion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "saadparwaiz1/cmp_luasnip",
            { "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets", },
        },
    },
    --==========================================================================
}

--=============================================================================
--=============================================================================

local opts = {}

--=============================================================================
--=============================================================================

require("lazy").setup(plugins, opts)




