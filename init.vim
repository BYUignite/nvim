"========== If vim instead of neovim...

if !has('nvim')
    source ~/.config/nvim/vim.vim
endif

"========== General settings

set cmdheight=1                  " height of the command window at the bottom

filetype on                       " detect file type
filetype plugin on                " read the ftplugins/somefile_for_given_type

set noshowmode                    " don't show mode (it is shown in airline here)
set backspace=2                   " make the backspace key always work.

set tabstop=4                     " set the tabstop to 4 spaces
set expandtab                     " convert tabs to  number of spaces; sse :set noexpandtab to disable
set shiftwidth=4                  " e.g., indenting code; should match tabstop
set smartindent                   " vim will try to help you indent your code.

set showmatch                     " show matching () {} etc...; use %, and see also vim-matchit plugin

set viminfo=!,%,'100,f1,<50,h,s10 " http://vimdoc.sourceforge.net/htmldoc/options.html#'viminfo'

set nosol                         " don't go to the beginning of line when G, gg, etc.; good for selecting cols in visual mode
set scrolloff=3                   " always see 3 lines above and below cursor (top/bottom)

set tags^=.git/tags;~             " run ctags -R at the top of a source tree; needs +path_extra (run vim --version)

set path+=**                      " allows searching in subdirectories

set pumheight=7                   " popup menu height size

set hidden                        " don't require save before opening/switching buffers"
"set clipboard=unnamedplus        " use system clipboard register by default (yy -> paste in other app, etc.), but BREAKS visual block paste

if has('mouse')
    set mouse=a                   " mouse support for all modes
    "set mouse=                   " turn off vim mouse handling
endif

autocmd FileType * set fo-=c fo-=r fo-=o  " see :h fo-table; not enough to just set fo:
autocmd BufEnter * set fo-=c fo-=r fo-=o  " see https://tinyurl.com/zehso5h

:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif    "open file at previous cursor location

set timeoutlen=300                " millisecond delay before recognize command completion and character combos

set diffopt+=vertical

set splitright
set splitbelow

"========== key mappings

"--- set leader key
let mapleader = ","

"--- remove trailing whitespace
nnoremap <leader>rtw :%s/\s\+$//e<CR>

"--- jj in insert mode to escape
inoremap jj <ESC>

"--- turn off search highlight
nnoremap <leader><space> :noh<cr>

"--- navigate between windows: hold down Ctrl then typel hjkl to move
"--- not needed with vim-tmux-navigator plugin
"noremap <C-j>     <C-W>j
"noremap <C-k>     <C-W>k
"noremap <C-h>     <C-W>h
"noremap <C-l>     <C-W>l

"--- nvim terminal and winndow navigation
if has('nvim')
    nmap <BS> <C-W>h

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap <expr> <Esc> "<c-\><c-n>"

endif

"--- tabbing: select lines and hit > or < to indentation block
vnoremap < <gv
vnoremap > >gv

"--- map to qa to avoid errors for multiple buffers open
nnoremap <leader>q :qa<CR>

"--- map to switch between header file and source file
" https://vim.fandom.com/wiki/Easily_switch_between_source_and_header_file
map <leader>s :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

"--- map jump to tag, as opposed to <C-]>
"--- can go back with <C-t> or with <C-o>
nnoremap <leader>t <C-]>

"========== folding (general, see file specific in ftplugins, like python)

set foldopen-=search              " don't open folds when searching
set foldmethod=marker             " select then zf to fold; za, zd, zc, space: toggles, delete, close, open

"========== hide and seek

set nowrapscan                    " do not wrap while searching (stop at bottom (or top) of file)
set ignorecase                    " ignores case on search (but see also smartcase)
set smartcase                     " with ignorecase searches with some caps will be case sensitive.
set cursorline                    " highlight the whole line where the cursor is
"set number                       " show line numbers; see also :set relativenumber for local/relative numbering

"========== Wrapping/file stuff   " http://vim.wikia.com/wiki/Automatic_word_wrapping

set nowrap                        " do not wrap lines longer than the window (not great for text, but fixed for file types below)
"set wrap linebreak nolist

"--- turn off syntax error checking on latex
let g:tex_no_error=1

augroup python " {
    autocmd!
    autocmd FileType python map  <buffer> <leader>rp :w<CR>:lcd %:p:h<CR>:exec '!python3' shellescape(@%, 1)<CR>:lcd -<CR>
    autocmd FileType python imap <buffer> <leader>rp <esc>:w<CR>::lcd %:p:h<CR>:exec '!python3' shellescape(@%, 1)<CR>:lcd -<CR>
augroup END " {

augroup latex_wrapping_nav " {
    autocmd!
    autocmd BufNewFile,BufRead *.tex set wrap linebreak nolist tw=0 wm=0
    autocmd BufNewFile,BufRead *.tex noremap j gj
    autocmd BufNewFile,BufRead *.tex noremap k gk
augroup END " }

augroup markdown " {
    autocmd!
    autocmd BufNewFile,BufRead *.md set wrap linebreak nolist tw=0 wm=0
    autocmd BufNewFile,BufRead *.md noremap j gj
    autocmd BufNewFile,BufRead *.md noremap k gk
    " for markdown-preview.nvim plugin:
    autocmd BufNewFile,BufRead *.md :nnoremap <leader>v :MarkdownPreview<CR>
    " for compiling reveal.js slides that start with 'lecture'
    autocmd BufNewFile,BufRead * if expand('%') =~ 'lecture*' | :nnoremap <leader>v :w<CR> :!./buildit.sh<CR> :!/Users/dol4/.config/nvim/chromerefresh.sh<CR> | endif
augroup END " }

augroup textfile " {
    autocmd!
    autocmd BufNewFile,BufRead *.txt set wrap linebreak nolist tw=0 wm=0
    autocmd BufNewFile,BufRead *.txt noremap j gj
    autocmd BufNewFile,BufRead *.txt noremap k gk
augroup END " }

"---------- for emphasizing comments in json files
augroup json " {
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END " {

"---------- for wrapping lines when using diff
autocmd VimEnter * if &diff | execute 'windo set wrap' | endif


"========== Syntax, Colors, Highlight: https://jonasjacek.github.io/colors/

set background=light
set t_Co=256
syntax enable

highlight VertSplit   ctermfg=24  ctermbg=NONE cterm=NONE
highlight Search      ctermbg=253 ctermfg=NONE cterm=bold
highlight MatchParen  ctermbg=253 ctermfg=NONE cterm=bold
highlight EndOfBuffer ctermfg=253 ctermbg=253
highlight CursorLine  cterm=bold
highlight Folded      ctermfg=248 ctermbg=015

"---------- Markdown, don't highlight underscores
highlight link markdownError Normal

"---------- diff colors
highlight DiffAdd    cterm=none ctermfg=none  ctermbg=249 gui=none
highlight DiffDelete cterm=none ctermfg=249   ctermbg=249 gui=none
highlight DiffChange cterm=none ctermfg=015   ctermbg=23  gui=none
highlight DiffText   cterm=none ctermfg=015   ctermbg=30  gui=none

"---------- sneak
highlight Sneak      ctermfg=black ctermbg=gray
highlight SneakScope ctermfg=black ctermbg=red
highlight SneakLabel ctermfg=black ctermbg=gray

"---------- popup menu
highlight Pmenu ctermbg=255 ctermfg=0

"============================================================================
"========== plugin manager: vim-plug
"============================================================================

" See https://github.com/junegunn/vim-plug
"
" run :PlugInstall to install all plugins below
" run :PlugUpdate to update
" run :PlugClean to remove unused plugins
" run :PlugUpgrade to update vim-plug itself

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'vifm/vifm.vim'                        " vifm file manager (instead of others, like nerdtree)
Plug 'rbgrouleff/bclose.vim'                " <leader>bd to delete buffer, or :Bclose, or :Bclose buffer#
Plug 'chrisbra/Colorizer'                   " show color codes with colors in vim; :ColorHighlight to show colors for codes
Plug 'karb94/neoscroll.nvim'                " smooth scrolling
Plug 'adelarsq/vim-matchit'                 " expands % functionality for finding matches, e.g., html tags
Plug 'vim-airline/vim-airline'              " nice appearance, statusbars, top buffer tabs
Plug 'vim-airline/vim-airline-themes'       " airline themes, e.g., papercolor
Plug 'edkolev/tmuxline.vim'                 " integrates tmux and airline
Plug 'christoomey/vim-tmux-navigator'       " helping with navigation between windows
Plug 'vim-scripts/loremipsum'               " :Loremipsum or :Loremipsum 1000 --> generates dummy text
Plug 'kassio/neoterm'                       " reuse terminal
Plug 'szw/vim-maximizer'                    " maximize current window
Plug 'tpope/vim-fugitive'                   " all things git
Plug 'tpope/vim-commentary'                 " nice commenting gcc gcap
Plug 'ludovicchabant/vim-gutentags'         " ctags autogenerated in git folders
Plug 'airblade/vim-rooter'                  " make folder with .git the root folder (allows fzf to search project, not just local)
Plug 'lervag/vimtex'                        " handy latex tools including mappings, etc.
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'rickhowe/diffchar.vim'                " improve diff'ing of files using vim

Plug 'neovim/nvim-lspconfig'                " language server protocol
Plug 'hrsh7th/cmp-nvim-lsp'                 " completion and related
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'         " snippet library
Plug 'hrsh7th/cmp-calc'
Plug 'onsails/lspkind-nvim'

Plug 'nvim-treesitter/nvim-treesitter'      " nice highlighting, etc.
Plug 'nvim-treesitter/nvim-treesitter-refactor'

"Plug 'SirVer/ultisnips'                    " snippets
"Plug 'honza/vim-snippets'                  " snippets

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

"============================================================================
" Plugins configuration
"============================================================================

"==================== completion (cmp), LSP (nvim-lspconfig), snippets
" do :h lsp and follow instructions:
"    (1) install nvim-lspconfig;
"    (2) install language servers, either :LspInstall or otherwise
"    (3) include the require'lspconfig'.clangd.setup{...} commands

lua <<EOF

local lsp = require('lspconfig')
lsp.clangd.setup({})
lsp.jedi_language_server.setup({})
lsp.texlab.setup({})
lsp.fortls.setup({})

-- Disable Diagnostcs globally
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
EOF

"------------------------------

set completeopt=menuone,noinsert,noselect
set shortmess+=c     " avoid showing message extra message when using completion

"------------------------------

lua <<EOF

local cmp     = require 'cmp'
local lspkind = require 'lspkind'

--https://github.com/hrsh7th/nvim-cmp/issues/417
cmp.register_source('cmdline_buffer', require('cmp_buffer').new())
cmp.setup.cmdline('/', {
    sources = {
        { name = 'cmdline_buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
    }
})
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
      },{
        { name = 'cmdline' }
    })
})

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  
  mapping = {
    ['<C-u>']     = cmp.mapping.scroll_docs(-10),
    ['<C-d>']     = cmp.mapping.scroll_docs(10),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<tab>']     = cmp.mapping.confirm { select = true },
    ['<CR>']     = cmp.mapping.confirm { select = true },
    -- Don't insert if I explicitly exit
    -- Start completion manually with C-Space to have it truly clean-up
    ['<C-e>'] = cmp.mapping.abort(),
    -- Insert instead of Select so you don't go away at `stopinsert` after `CursorHoldI`
    -- @TODOUA: I want to be able to `Select` without `stopinsert` killing it (& keep `stopinsert`)
    ['<Up>']   = cmp.mapping(cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, { 'i', 'c' }),
  },
  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'calc' },
    {
      name = 'buffer',
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp   = 'ﲳ',
        nvim_lua   = '',
        treesitter = '',
        path       = 'ﱮ',
        buffer     = '﬘',
        zsh        = '',
        vsnip      = '',
        spell      = '暈',
      })[entry.source.name]

      return vim_item
    end,
  },
}

-- snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lsp configuration
local lsp = require('lspconfig')
capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.clangd.setup({               capabilities = capabilities, })
lsp.jedi_language_server.setup({ capabilities = capabilities, })
lsp.texlab.setup( {              capabilities = capabilities, })
lsp.fortls.setup({               capabilities = capabilities, })

-- Disable Diagnostcs globally
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

EOF

let g:vsnip_snippet_dir="/Users/dol4/.config/nvim/snippets_dol/"

"==================== telescope

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <leader>g <cmd>Telescope grep_string<cr>
nnoremap <leader>g <cmd>Telescope grep_string<cr>
nnoremap <leader>T <cmd>Telescope tags<cr>


"-------- https://vimawesome.com/plugin/telescope-nvim-care-of-itself
"-------- https://github.com/whatsthatsmell/dots/blob/master/public%20dots/vim-nvim/lua/joel/telescope/init.lua
lua<<EOF
require('telescope').setup{
  defaults = {
    prompt_prefix = "➤ ",
    selection_caret = "➤ ",
    entry_prefix = "  ",
    }
}
EOF

"====================

""----------- Mappings
"" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>



"==================== treesitter (better highlighting)
" do :TSInstall <tab> then select languages
" incremental keymaps are <Alt+kjl> for scope_incremental, node_decremental, node_incremental

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight             = { enable = true },
  indent                = { enable = true },
  incremental_selection = { enable = true,
                            keymaps = {init_selection    = "gss",
                                       scope_incremental = "˚",
                                       node_decremental  = "∆",
                                       node_incremental  = "¬"}},
  refactor              = { highlight_definitions   = { enable = true },
                            highlight_current_scope = { enable = false } },
}
EOF

set updatetime=1000       " time to wait on cursor hold to highlight

"==================== fugitive



"==================== vim-maximizer
nnoremap <leader>m :MaximizerToggle!<CR>

"==================== vim-commentary
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s


"==================== gutentags

let g:gutentags_enabled = 0
augroup auto_gutentags
  au FileType python,java,scala,json,yml,yaml,css,scss,less,xml,html,xhtml,svg,js,javascript,ts,typescript let g:gutentags_enabled=1
augroup end

"==================== diffchar

let g:DiffUnit = 'Word1'
let g:DiffColors = 0
let g:DiffPairVisible = 1

"==================== markdown-preview
"Plug 'JamshedVesuna/vim-markdown-preview'

"let vim_markdown_preview_hotkey='<leader>v'
"let vim_markdown_preview_browser='Google Chrome'
"let vim_markdown_preview_pandoc=1

"==================== neoscroll

lua <<EOF
    require('neoscroll').setup({
    })

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
t['zt']    = {'zt', {'250'}}
t['zz']    = {'zz', {'250'}}
t['zb']    = {'zb', {'250'}}

require('neoscroll.config').set_mappings(t)

EOF


"==================== vifm config

let g:vifm_embed_split=1
noremap <leader>fm :vertical 40Vifm<CR>

"==================== Airline config

"---- show top bar
let g:airline#extensions#tabline#enabled = 1

"---- show buffer number top bar
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='dol_airline_2'
"let g:airline_theme='papercolor'
"let g:airline_theme='luna'

"---- don't show file type or encoding
let g:airline_section_x=''
let g:airline_section_y=''

"---- wordcount
let g:airline#extensions#wordcount#enabled = 0

"---- complain about trailing whitespace
let g:airline#extensions#whitespace#enabled = 1

"---- airline symbols;
"---- note: to get fonts working on mac run this: https://github.com/powerline/fonts
"---- see :help airline for a list of common symbols and commands to change em
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.whitespace = '➲'
let g:airline_symbols.colnr = ' ‖ '
let g:airline_symbols.linenr = ' ☰ '

"---- for tmuxline + vim-airline integration
let g:airline#extensions#tmuxline#enabled = 1

"---- start tmuxline even without vim running
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

let g:tmuxline_powerline_separators = 0

"==================== ultisnips, vim-snippets

"let g:UltiSnipsExpandTrigger = '<leader><Tab>'

"==================== vimtex

let g:vimtex_view_method = 'skim'

"---- make sure latex sees .tex files as .tex files (:h vimtex --> tex_flavor)
let g:tex_flavor = "latex"

"---- compile and view latex
augroup latex_macros " {
    autocmd!
    autocmd FileType tex :nnoremap <leader>v :w<cr> :VimtexCompile<cr>
augroup END " }

if has("nvim")
  let g:vimtex_compiler_progname = 'nvr'
endif

"==================== neoterm

let g:neoterm_default_mod = 'botright'
let g:neoterm_autoinsert = 1
let g:neoterm_size = 20
nnoremap <leader>r :Ttoggle<CR>
inoremap <leader>r :Ttoggle<CR>
tnoremap <leader>r :Ttoggle<CR>


"========================================================================

"======= hit <C-n> in insert mode to show completion
if has('unix')
    set dictionary+=/usr/share/dict/words
endif
set complete+=k

"https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
":inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

