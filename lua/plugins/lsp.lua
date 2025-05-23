--=============================================================================================
----- download and install language servers (mason)

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

-----------------------------------------------------------------------------------------------

for srv, _ in pairs(servers) do
    _ = require("mason-registry").is_installed(srv) or vim.cmd("MasonInstall " .. srv)
end

-----------------------------------------------------------------------------------------------

local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, srv in pairs(servers) do       -- like lsp.clangd.setup( {capabilities = capabilities} )
    lsp[srv].setup( {capabilities = capabilities} )
end

--=============================================================================================
----- completion

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
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip"  },
        { name = "buffer"   },
        { name = "nvim_lua" },
        { name = "path"     },
        { name = "calc"     },
    },
    -- mapping = {} -- this is set in ../keymaps.lua
})

--=============================================================================================
----- snippets

local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"
require("luasnip.loaders.from_vscode").lazy_load { paths = snippets_path }
