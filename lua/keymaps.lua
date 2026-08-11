--=============================================================================
------ leader key

vim.g.mapleader = ","

--=============================================================================

local map = vim.keymap.set

map("n",             "j",               "gj",                         {desc = "go down for regular and wrapped lines"})
map("n",             "k",               "gk",                         {desc = "go up for regular and wrapped lines"})
map("n",             "<Esc>",           ":noh<CR>",                   {desc = "cancel search highlight"})
map("n",             "<leader>n",       ":set nu!<CR>",               {desc = "toggle line numbers"})
map("n",             "<leader>nr",      ":set rnu!<CR>",              {desc = "toggle relative line numbers"})
map("n",             "<leader>rtw",     ":%s/\\s\\+$//e<CR>",         {desc = "remove trailing whitespace"})
map("n",             "<leader>s",       ":A<CR>",                     {desc = "switch between header and source file"})
map("n",             "<leader>e",       "<cmd>Yazi<CR>",              {desc = "open yazi at current file"})
map("v",             ">",               ">gv",                        {desc = "indent"});
map("t",             "<Esc>",           "<C-\\><C-n>",                {desc = "terminal escape to normal mode"})
map("i",             "jj",              "<Esc>",                      {desc = "another way to escape"})
map({"i", "n", "v"}, "<leader>wc",      "g<C-g>",                     {desc = "word count"})
map({"i", "n"},      "<leader>w",       ":w<CR>",                     {desc = "save buffer"})
map("n",             "<leader>zt",      ":<C-u>exec 'normal! ' . 15 . 'kzt' . 15 . 'j' <CR>", {desc = "Custom scroll so cursor is 15 lines from the top"})

--=============================================================================
-- see md_qmd.lua and ftplugin/markdown.lua and ftplugin/quarto.lua (which just call md_qmd.lua)
-- for detailed configuration and keymaps that enable running and navigating code in md and qmd files

--=============================================================================
------ latex compile

map("n", "<leader>v", function()
    if vim.bo.filetype == "tex" then
        vim.cmd("write")
        vim.cmd("VimtexCompile")
    end
end, {desc = "run view commands: markdown, latex"})

--=============================================================================
------ toggle colorschemes

map("n", "<leader>cm", function()
    if vim.g.colors_name == "repent" then
        vim.cmd("colorscheme forsake")
        vim.g.LASTCM = "forsake"
    else
        vim.cmd("colorscheme repent")
        vim.g.LASTCM = "repent"
    end
end, {desc = "toggle colorschemes"})

--=============================================================================
------ maximizer plugin

vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>lua require("maximizer").toggle()<CR>', {silent = true, noremap = true})

--=============================================================================
------ telescope plugin

-- map("n", "<leader>f",  ":Telescope git_files <CR>",      { desc = "telescope find git project files" })
-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "telescope find files" })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",     { desc = "telescope find buffers" })
-- map("n", "<leader>ma", "<cmd>Telescope marks<CR>",       { desc = "telescope find marks" })
-- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
-- map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
-- map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope themes" })
-- map("n", "<leader>mm", "<cmd>Telescope keymaps<CR>", { desc = "telescope show all known keymappings"})
--
-- ---- code: jump to definitions, etc. ctrl-o to go back; ctrl-i to go forward
-- map("n", "<leader>cd", "<cmd>Telescope lsp_definitions<CR>",      { desc = "telescope: definition for word under cursor"})
-- map("n", "<leader>ct", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "telescope: go to the definition of the type of the word under cursor"})
-- map("n", "<leader>cr", "<cmd>Telescope lsp_references<CR>",       { desc = "telescope: references for word under cursor"})
-- map("n", "<leader>ci", "<cmd>Telescope lsp_implementations<CR>",  { desc = "telescope: go to the implementation of the word under cursor"})
--
-- map("n", "<leader>gr", function()
--   require('telescope.builtin').live_grep({
--     cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
--   })
-- end,                                                              { desc = "telescope live grep" })
-- map("n", "<leader>gg", function()
--   require('telescope.builtin').grep_string({
--     cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
--   })
-- end,                                                              { desc = "telescope grep word under cursor" })

--=============================================================================
------ fff plugin

--map("n", 'ff', function() require('fff').find_files() end, { desc = 'fff find files' })
--map("n", 'fg', function() require('fff').live_grep()  end, { desc = 'fff grep' })
--map("n", 'fz', function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end, { desc = 'fff fuzzy grep'})
--map("n", 'fc', function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end, { desc = 'fff search current word'})

--=============================================================================
------ neoterm plugin

map({"i", "n", "t"}, "<leader>t", ":Ttoggle<CR>", {desc = "Custom toggle terminal"})

--=============================================================================
------ nvim_tmux_navigation plugin

map("n", "<C-h>", ":NvimTmuxNavigateLeft<CR>",  {desc = "Tmux go left"})
map("n", "<C-j>", ":NvimTmuxNavigateDown<CR>",  {desc = "Tmux go down"})
map("n", "<C-k>", ":NvimTmuxNavigateUp<CR>",    {desc = "Tmux go up"})
map("n", "<C-l>", ":NvimTmuxNavigateRight<CR>", {desc = "Tmux go right"})

--=============================================================================
------ barbar plugin (buffers)

map("n", "<Tab>",":BufferNext<CR>",       {desc = "go to next buffer"})
map("n", "<S-Tab>",":BufferPrevious<CR>", {desc = "go to previous buffer"})
map("n", "<leader>x",":BufferClose<CR>",  {desc = "close buffer"})

map("n", "<leader>1",":BufferGoto 1<CR>", {desc = "switch to buffer 9"})
map("n", "<leader>2",":BufferGoto 2<CR>", {desc = "switch to buffer 8"})
map("n", "<leader>3",":BufferGoto 3<CR>", {desc = "switch to buffer 7"})
map("n", "<leader>4",":BufferGoto 4<CR>", {desc = "switch to buffer 6"})
map("n", "<leader>5",":BufferGoto 5<CR>", {desc = "switch to buffer 5"})
map("n", "<leader>6",":BufferGoto 6<CR>", {desc = "switch to buffer 4"})
map("n", "<leader>7",":BufferGoto 7<CR>", {desc = "switch to buffer 3"})
map("n", "<leader>8",":BufferGoto 8<CR>", {desc = "switch to buffer 2"})
map("n", "<leader>9",":BufferGoto 9<CR>", {desc = "switch to buffer 1"})

--=============================================================================

----======== LSP: jump to defintion, etc.
---- for explanations: https://www.reddit.com/r/neovim/comments/11u3sx3/lsp_differences_between_definition_declaration/
---- ctrl-o to go back; ctrl-i to go forward
-- (these are done above in telescope instead)
--
--map("n", "gd", vim.lsp.buf.definition,     {desc = "go to definition"})
--map("n", "gD", vim.lsp.buf.declaration,    {desc = "go to declaration"})
--map("n", "gD", vim.lsp.buf.type_definition,{desc = "go to type definition of given symbol"})
--map("n", "gr", vim.lsp.buf.references,     {desc = "go to references (use instances) of given symbol"})
--map("n", "gi", vim.lsp.buf.implementation, {desc = "go to implmentation (virtual defs)"})
