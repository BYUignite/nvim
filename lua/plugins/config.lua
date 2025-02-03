
-------------------------------------------------------------------------------
-- make sure language servers are installed

local servers = {["clangd"]                = "clangd",
                 ["fortls"]                = "fortls",
                 ["jedi-language-server"]  = "jedi_language_server",
                 ["julia-lsp"]             = "julials",
                 ["marksman"]              = "marksman",
                 ["texlab"]                = "texlab",
                 ["lua-language-server"]   = "lua_ls",
                 ["cmake-language-server"] = "cmake",
                 --["yaml-language-server"]  = "yamlls",
             }
for srv, _ in pairs(servers) do
    _ = require("mason-registry").is_installed(srv) or vim.cmd("MasonInstall " .. srv)
end

-------------------------------------------------------------------------------
-- setup completion

local cmp = require('cmp')

cmp.setup({

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    -- mapping = {} -- this is set in keymaps.lua

    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip"  },
        { name = "buffer"   },
        { name = "nvim_lua" },
        { name = "path"     },
        { name = "calc"     },
    },
})

-------------------------------------------------------------------------------
-- setup lsp

local lsp = require('lspconfig')

--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, srv in pairs(servers) do       -- like lsp.clangd.setup( {capabilities = capabilities} )
    lsp[srv].setup( {capabilities = capabilities} )
end

-------------------------------------------------------------------------------
-- snippets

local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"
require("luasnip.loaders.from_vscode").lazy_load { paths = snippets_path }

---------------------------------------------------------------------------------
---- 3rd/image.nvim
--
--local img = require('image')
--img.setup({
--    backend = "kitty",
--    processor = "magick_rock", -- or "magick_cli"
--    integrations = {
--        markdown = {
--            enabled = true,
--            clear_in_insert_mode = false,
--            download_remote_images = true,
--            only_render_image_at_cursor = false,
--            floating_windows = false, -- if true, images will be rendered in floating markdown windows
--            filetypes = { "markdown", "vimwiki", "quarto" }, -- markdown extensions (ie. quarto) can go here
--        },
--        neorg = {
--            enabled = true,
--            filetypes = { "norg" },
--        },
--        typst = {
--            enabled = true,
--            filetypes = { "typst" },
--        },
--        html = {
--            enabled = false,
--        },
--        css = {
--            enabled = false,
--        },
--    },
--    max_width = 100,
--    max_height = 12,
--    max_width_window_percentage = math.huge,
--    max_height_window_percentage = math.huge,
--    window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
--    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
--    editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
--    tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
--    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
--})
--
---------------------------------------------------------------------------------
---- 3rd/image.nvim
--
--local headlines = require('headlines')
--headlines.setup({
--    quarto = {
--        dash_string = "⚯",
--        headline_highlights = { "Headline1", "Headline2", "Headline3" },
--        query = vim.treesitter.query.parse(
--        'markdown', 
--        [[
--        (atx_heading [
--        (atx_h1_marker)
--        (atx_h2_marker)
--        (atx_h3_marker)
--        (atx_h4_marker)
--        (atx_h5_marker)
--        (atx_h6_marker)
--        ] @headline)
--
--        (thematic_break) @dash
--
--        (fenced_code_block) @codeblock
--
--        (block_quote_marker) @quote
--        (block_quote (paragraph (inline (block_continuation) @quote)))
--        (block_quote (paragraph (block_continuation) @quote))
--        (block_quote (block_continuation) @quote)
--        ]]
--        ),
--        bullet_highlights = {
--            "@text.title.1.marker.markdown",
--            "@text.title.2.marker.markdown",
--            "@text.title.3.marker.markdown",
--            "@text.title.4.marker.markdown",
--            "@text.title.5.marker.markdown",
--            "@text.title.6.marker.markdown",
--        },
--        bullets = { "◉", "○", "✸", "✿" },
--        codeblock_highlight = "CodeBlock",
--        dash_highlight = "Dash",
--        dash_string = "-",
--        quote_highlight = "Quote",
--        quote_string = "┃",
--        fat_headlines = true,
--        fat_headline_upper_string = "▄",
--        fat_headline_lower_string = "▀",
--        treesitter_language = 'markdown',
--    },
--    markdown = {
--        dash_string = "⚯",
--        headline_highlights = { "Headline1", "Headline2", "Headline3" },
--        query = vim.treesitter.query.parse(
--        'markdown', 
--        [[
--        (atx_heading [
--        (atx_h1_marker)
--        (atx_h2_marker)
--        (atx_h3_marker)
--        (atx_h4_marker)
--        (atx_h5_marker)
--        (atx_h6_marker)
--        ] @headline)
--
--        (thematic_break) @dash
--
--        (fenced_code_block) @codeblock
--
--        (block_quote_marker) @quote
--        (block_quote (paragraph (inline (block_continuation) @quote)))
--        (block_quote (paragraph (block_continuation) @quote))
--        (block_quote (block_continuation) @quote)
--        ]]
--        ),
--        bullet_highlights = {
--            "@text.title.1.marker.markdown",
--            "@text.title.2.marker.markdown",
--            "@text.title.3.marker.markdown",
--            "@text.title.4.marker.markdown",
--            "@text.title.5.marker.markdown",
--            "@text.title.6.marker.markdown",
--        },
--        bullets = { "◉", "○", "✸", "✿" },
--        codeblock_highlight = "CodeBlock",
--        dash_highlight = "Dash",
--        dash_string = "-",
--        quote_highlight = "Quote",
--        quote_string = "┃",
--        fat_headlines = true,
--        fat_headline_upper_string = "▄",
--        fat_headline_lower_string = "▀",
--    },
--})
