-- See this link, gsinclair's answer for information on config and opts and how they are related:
-- https://neovim.discourse.group/t/different-ways-to-configure-plugins-through-lazy-vim-what-do-they-mean-and-which-one-do-i-use/4199/5



--======== bootstrap lazy.nvim to get it if it's not already here

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

--======== 

local plugins = {

    --=============================================================================================
    {
        -- move between vim windows and tmux windows seemlessly (same command)
        "alexghergh/nvim-tmux-navigation",
        lazy = false,
        config = function()
            local nvim_tmux_nav = require('nvim-tmux-navigation')
            nvim_tmux_nav.setup({
                disable_when_zoomed = true -- defaults to false
            })
        end
    },
    --=============================================================================================
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    --=============================================================================================
    {
        -- generate dummy text :Loremipsum or :Loremipsum 1000
        "vim-scripts/loremipsum",
        ft = {'markdown', 'text', 'tex', 'plaintex'}
    },
    --=============================================================================================
    {
        -- switch between header file and source file
        "vim-scripts/a.vim",
        lazy = false,
    },
    --=============================================================================================

    {
        "declancm/cinnamon.nvim",
        config = function()
            require("cinnamon").setup({
                keymaps = {
                    basic = true,
                    extra = true,
                },
                options = { 
                    mode = "cursor",
                    delay = 7,
                    max_delta = { line = 150, column = false, time = 1000, },
                    step_size = {vertical=1, horizontal=2,},
                },
            })
        end,
    },



    --=============================================================================================
    {
        -- with multiple windows, allows toggling the current window to full size
        "szw/vim-maximizer",
        lazy = false,
    },
    --=============================================================================================
    {
        -- easily open and close terminal
        "kassio/neoterm",
        lazy = false,
        config = function()
            vim.g.neoterm_default_mod = 'botright'
            vim.g.neoterm_autoinsert = 1
            vim.g.neoterm_size = 20
        end,
    },
    --=============================================================================================
    {
        -- compile/view markdown in a browser while editing code in vim
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    --=============================================================================================
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
    --=============================================================================================
    {
        -- file explorer
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({})
        end,
    },
    --=============================================================================================
    {
        -- show color of colorcodes: #587b7b
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    },
    --=============================================================================================

    --{
    --    -- show vertical lines at indentation levels
    --    "lukas-reineke/indent-blankline.nvim",
    --    main = "ibl",
    --    ---@module "ibl"
    --    ---@type ibl.config
    --    opts = {},
    --    config = function()
    --        require("ibl").setup()
    --    end,
    --},






    --{
    --    "lukas-reineke/indent-blankline.nvim",
    --    --event = "User FilePost",
    --    opts = {
    --        indent = { char = "│", highlight = "IblChar" },
    --        scope = { char = "│", highlight = "IblScopeChar" },
    --    },
    --    config = function(_, opts)
    --        --dofile(vim.g.base46_cache .. "blankline")

    --        --local hooks = require "ibl.hooks"
    --        --hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    --        require("ibl").setup(opts)

    --        --dofile(vim.g.base46_cache .. "blankline")
    --    end,
    --},

    --=============================================================================================
    {
        -- buffer tabs at top
        "romgrk/barbar.nvim",
        --enabled = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            icons = {filetype = {custom_colors=true, enabled=true}}
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0',              -- OPTIONAL: only update when a new 1.x version is released
    },
    --=============================================================================================

    { "rktjmp/lush.nvim", lazy=true },

    { dir = vim.fn.stdpath("config") .. "/lua/themes/repent" ,  lazy=true },
    { dir = vim.fn.stdpath("config") .. "/lua/themes/forsake" , lazy=true },

    --=============================================================================================
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "c", "cpp", "vim", "vimdoc", "lua", "css", "html", "make", "bash",
                "yaml", "java", "json", "cmake", "fortran", "julia", "python",
                "bibtex", "markdown", "typescript", "dockerfile"
            }
        }
    },
    --=============================================================================================
    {
        -- Git signs
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
            })
        end
    },
    --=============================================================================================
    {
        -- Git goodness
        "tpope/vim-fugitive",
    },
    --=============================================================================================
    {
        -- telescope file finder etc.
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
            })
        end
    },
    --=============================================================================================
    -- LSP, Completion, Snippets
    -- CONFIGURATION IS IN configs folder
    {
        -- get lsp servers; servers are auto-downloaded in the ~/.config/nvim/init.lua file
        "williamboman/mason.nvim",
        config = function() 
            require("mason").setup({
                ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } }
            }) 
        end
    },

    --------------------------------

    { "neovim/nvim-lspconfig" },

    --------------------------------

    { 
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            { "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets", },
            "saadparwaiz1/cmp_luasnip",
        },
    },
  --=============================================================================================
    {
        "windwp/nvim-autopairs",
        opts = { fast_wrap = {}, },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    --=============================================================================================

}

--======== 

local opts = {}

--======== 

require("lazy").setup(plugins, opts)
