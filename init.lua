--======== General options

local g   = vim.g
local o   = vim.o
local opt = vim.opt                             -- like :set option=value

--------------------------------------------

o.cursorlineopt = "both"                        -- enable highlighting the line the cursor is on
o.clipboard     = "unnamedplus"                 -- clipboard integration: <C-c> then put; yank then <C-v>

opt.number        = false
opt.wrapscan      = false
opt.expandtab     = true
opt.tabstop       = 4
opt.shiftwidth    = 4
opt.smartindent   = true
opt.wrap          = false
opt.showmatch     = true
opt.shada         = "!,'100,f1,<50,h,s10"     -- "!,%,'100,f1,<50,h,s10"    -- the % remembers which files were open
opt.timeoutlen    = 300
opt.signcolumn    = "no"
opt.whichwrap     = "bs"                        -- reset default (don't wrap on left right motion through lines)
opt.showtabline   = 2
opt.termguicolors = true                        -- needed for colorizer
opt.ignorecase    = true
opt.smartcase     = true
opt.mouse         = "a"
opt.undofile      = true                        -- remember undo on file open/close
opt.cursorline    = true                        -- highlight the current line
opt.showmode      = false                       -- don't show mode "insert, normal, visual..."; it's in statusline
opt.shortmess:append "sI"                       -- I: don't show welcome message; s: don't show search messages
opt.fillchars = { eob = " " }                   -- character for visible lines at the end of file
opt.signcolumn = "yes:1"                        -- space at first column

---------- don't continue comments on enter, etc. see :h fo-table

vim.cmd("autocmd FileType * set fo-=r fo-=c fo-=o")

---------- open file at previous cursor location

vim.cmd([[au BufReadPost * if line("'\"") > 1 &&
    \ line("'\"") <= line("$") |
    \ exe "normal! g`\"" | endif]])

---------- Folding

opt.foldopen:remove({"search"})                 -- don't open folds when searching
opt.foldmethod = "marker"                       -- select then zf to fold; za, dz, zc, space: toggles, delete, close, open

---------- Autocommands

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufNewFile", "BufRead"}, {            --  text, markdown, latex
    pattern = {"*.txt", "*.md", "*.tex"},
    callback = function()
        opt.wrap = true
        opt.linebreak = true
        opt.list = false
        opt.tw = 0
        opt.wm = 0
    end
})

---------- disable diagnostcs globally (diagnostics are a pain)

vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

--======== plugins

require("plugins")
require("plugins.config")

--======== keymaps

require("keymaps")

--======== colorscheme

--vim.cmd("colorscheme forsake")
vim.cmd("colorscheme repent")

--======== statusline

require("statusline")
