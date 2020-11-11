"TODO: wrapping text: formatoptions

if !has('nvim')
    source ~/.config/nvim/vim.vim
endif

"========== General setting

filetype on
filetype plugin on

set noshowmode                    " Tell us when we're in insert mode. (This is shown elsewhere)
set backspace=2                   " Make the backspace key always work.

set tabstop=4                     " Set the tabstop to 4 spaces
set shiftwidth=4                  " Shiftwidth should match tabstop
set expandtab                     " Convert tabs to  number of spaces; Use :set noexpandtab to disable

set showmatch                     " Show matching () {} etc...; use %, and see also vim-matchit plugin

set smartindent                   " vim will try to help you indent your code.

set viminfo=!,%,'100,f1,<50,h,s10 " http://vimdoc.sourceforge.net/htmldoc/options.html#'viminfo'

set nosol                         " don't go to the beginning when G in visual: good for selecting columns
set scrolloff=3                   " always see 3 lines above and below cursor

set tags^=.git/tags;~             " run ctags -R at the top of a source tree; needs +path_extra (run vim --version)

set path+=**
set pumheight=7                   " popup menu height size

set hidden                        " Don't require save before opening/switching buffers"
"set clipboard=unnamedplus         " Use system clipboard register by default (yy -> paste in other app, etc.), but BREAKS visual block paste

if has('mouse')
    set mouse=a                   " mouse support for all modes
endif

autocmd FileType * set fo-=c fo-=r fo-=o  " see :h fo-table; not enough to just set fo:
autocmd BufEnter * set fo-=c fo-=r fo-=o  " see https://tinyurl.com/zehso5h

:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif    "open file at previous cursor location

set timeoutlen=300                " millisecond delay before recognize command completion and character combos

"========== key mappings

"--- set leader key
let mapleader = ","

"--- remove trailing whitespace
nnoremap <leader>rtw :%s/\s\+$//e<CR>

"--- jj in insert mode to escape
inoremap jj <ESC>

"--- turn off search highlight
nnoremap <leader><space> :noh<cr>

"--- navigate between windows
noremap <C-j>     <C-W>j
noremap <C-k>     <C-W>k
noremap <C-h>     <C-W>h
noremap <C-l>     <C-W>l

"--- nvim terminal and winndow navigation
if has('nvim')
    nmap <BS> <C-W>h

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    "tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

endif

"--- tabbing: select lines and hit > or < to indentation block
vnoremap < <gv
vnoremap > >gv

"--- map to qa to avoid errors for multiple buffers open
nnoremap <leader>q :qa<CR>

"--- map to switch between header file and source file
" https://vim.fandom.com/wiki/Easily_switch_between_source_and_header_file
map <leader>s :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

"--- map jump to tag, as opposed to <C-]>, see also Denite: <leader>T for more control over tag jumps
"--- can go back with <C-t> or with <C-o> (the latter is useful with Denite <leader> T, which doesn't change the tag stack, so <C-t> doesn't work)
nnoremap <leader>t <C-]>    

"========== Folding (general, see file specific in ftplugins, like python)

set foldopen-=search              " don't open folds when searching
set foldmethod=marker             " select then zf to fold; za, zd, zc, space: toggles, delete, close, open

"========== Hide and Seek

set nowrapscan                    " do not wrap while searching
set ignorecase                    " ignores case on search
set smartcase                     " with ignorecase searches with some cap will be case sensitive.
set cursorline                    " select the current line
"set number                       " Show line numbers

"========== Wrapping              " http://vim.wikia.com/wiki/Automatic_word_wrapping

set nowrap                        " do not wrap lines longer than the window
"set wrap linebreak nolist

let g:tex_no_error=1

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


"========== Syntax, Colors, Highlight: https://jonasjacek.github.io/colors/

set background=light
set t_Co=256
syntax enable

highlight VertSplit   ctermfg=24  ctermbg=NONE cterm=NONE
highlight Search      ctermbg=253 ctermfg=NONE cterm=bold
highlight MatchParen  ctermbg=253 ctermfg=NONE cterm=bold
highlight EndOfBuffer ctermfg=253 ctermbg=253
highlight CursorLine  cterm=bold

"---------- Markdown, don't highlight underscores
highlight link markdownError Normal

"---------- diff colors
highlight DiffAdd    cterm=none ctermfg=none  ctermbg=253 gui=none
highlight DiffDelete cterm=none ctermfg=253   ctermbg=253 gui=none
highlight DiffChange cterm=none ctermfg=255   ctermbg=23  gui=none
highlight DiffText   cterm=none ctermfg=255   ctermbg=30  gui=none

"---------- sneak
highlight Sneak      ctermfg=black ctermbg=gray
highlight SneakScope ctermfg=black ctermbg=red
highlight SneakLabel ctermfg=black ctermbg=gray

"---------- popup menu
highlight Pmenu ctermbg=255 ctermfg=0

""---------- fzf

highlight fzf_window  ctermbg=254 ctermfg=0
highlight fzf_border              ctermfg=254
highlight fzf_gutter              ctermfg=254
highlight fzf_marker  ctermbg=240 ctermfg=15
highlight fzf_prompt              ctermfg=160
highlight fzf_pointer             ctermfg=240
highlight fzf_info                ctermfg=254
highlight fzf_hl                  ctermfg=160

"============================================================================
"========== plugin manager: vim-plug
"============================================================================

" See https://github.com/junegunn/vim-plug 
" Install vim-plug plugin manager:
"     curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
Plug 'majutsushi/tagbar'                    " open a window pane with class/function outline <F2> mapped

Plug 'chrisbra/Colorizer'                   " Show color codes with colors in vim
Plug 'JuliaEditorSupport/julia-vim'         " julia support, formatting, also allows easy greek letters: \alpha<tab>

Plug 'terryma/vim-smooth-scroll'            " <C-f> <C-b> <C-u> <C-d> scoll smoothly, rather than jump
Plug 'justinmk/vim-sneak'                   " nice motion/find (compares with easymotion); invoke with s{char}{char} or S{char}{char}
Plug 'adelarsq/vim-matchit'                 " expands % functionality for finding matches, e.g., html tags

Plug 'vim-airline/vim-airline'              " nice appearance, statusbars, top buffer tabs
Plug 'vim-airline/vim-airline-themes'       " airline themes, e.g., papercolor

Plug 'edkolev/tmuxline.vim'                 " integrates tmux and airline
Plug 'christoomey/vim-tmux-navigator'       " helping with navigation between windows

Plug 'vim-scripts/loremipsum'

Plug 'tpope/vim-fugitive'                   " all things git
Plug 'ludovicchabant/vim-gutentags'         " ctags autogenerated in git folders
Plug 'airblade/vim-rooter'                  " make folder with .git the root folder (allows fzf to search project, not just local)

Plug 'nvim-treesitter/nvim-treesitter'      " highlighting, etc.
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'neovim/nvim-lspconfig'                " language server protocol
Plug 'nvim-lua/completion-nvim'             " code completion

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'lervag/vimtex'                        " handy latex tools including mappings, etc.


call plug#end()

"============================================================================
" Plugins configuration
"============================================================================

"==================== julia-vim
" julia formatting and latex characters via \alpha<tab>

let g:latex_to_unicode_file_types = ".*"
let g:latex_to_unicode_auto = 1
autocmd FileType tex :let g:latex_to_unicode_auto = 0

"==================== vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 7, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 7, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 1)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 1)<CR>

" mac key repeat rate; bash commands; need to restart
" defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
" defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

"==================== vifm config

let g:vifm_embed_split=1
noremap <leader>fm :vertical 40Vifm<CR>

"==================== Airline config

"---- show top bar
let g:airline#extensions#tabline#enabled = 1

"---- show buffer number top bar
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='dol_airline'
"let g:airline_theme='papercolor'
"let g:airline_theme='luna'

"---- don't show file type or encoding
let g:airline_section_x=''
let g:airline_section_y=''

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

"---- for tmuxline + vim-airline integration  
let g:airline#extensions#tmuxline#enabled = 1

"---- start tmuxline even without vim running
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

let g:tmuxline_powerline_separators = 0

"==================== sneak

let g:sneak#s_next = 1
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

"==================== treesitter
" do :TSInstall <tab> then select languages (or just do :TSInstall all)
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
  refactor                = { highlight_definitions   = { enable = true }, 
                              highlight_current_scope = { enable = false }},
}
EOF

set updatetime=1000       " time to wait on cursor hold to highlight

"==================== LSP (Language Server Protocol): nvim-lspconfig, completion-nvim
" do :h lsp and follow instructions: 
"    (1) install nvim-lspconfig;
"    (2) install language servers, either :LspInstall or otherwise
"    (3) include the require'nvim_lsp'.clangd.setup{...} commands

lua <<EOF
require'nvim_lsp'.clangd.setup{on_attach=require'completion'.on_attach}
require'nvim_lsp'.jedi_language_server.setup{on_attach=require'completion'.on_attach}
require'nvim_lsp'.julials.setup{on_attach=require'completion'.on_attach}
require'nvim_lsp'.bashls.setup{on_attach=require'completion'.on_attach}
require'nvim_lsp'.texlab.setup{on_attach=require'completion'.on_attach}

-- Disable Diagnostcs globally
vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end
EOF

set completeopt=menuone,noinsert,noselect    " for better completion experience
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 0

set shortmess+=c     " avoid showing message extra message when using completion

"----------- Mappings
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>c :CompletionToggle<cr>

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>

"==================== ultisnips, vim-snippets

let g:UltiSnipsExpandTrigger = '<leader><Tab>'

"==================== vimtex

let g:vimtex_view_general_viewer = 'open -a preview'

"---- make sure latex sees .tex files as .tex files (:h vimtex --> tex_flavor)
let g:tex_flavor = "latex"

"---- compile and view latex
augroup latex_macros " {
    autocmd!
    autocmd FileType tex :nnoremap <leader>v :w<cr> :VimtexCompile<cr>
    "autocmd FileType tex :nnoremap <leader>c :w<CR>:!rubber --pdf --warn all %<CR>
    "autocmd FileType tex :nnoremap <leader>v :!open -a preview %:r.pdf &<CR><CR>
augroup END " }

let g:vimtex_latexmk_options = '-pdf -verbose -bibtex -file-line-error -synctex=1 --interaction=nonstopmode'

"==================== fzf

let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>G :Ag
nnoremap <silent> <leader>g :call SearchWordWithAg()<CR>

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

"------------ window layout and colors

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4 } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'fzf_window'],
  \ 'bg':      ['bg', 'fzf_window'],
  \ 'hl':      ['fg', 'fzf_hl'],
  \ 'fg+':     ['fg', 'fzf_marker'],
  \ 'bg+':     ['bg', 'fzf_marker'],
  \ 'hl+':     ['fg', 'fzf_marker'],
  \ 'info':    ['fg', 'fzf_info'],
  \ 'border':  ['fg', 'fzf_border'],
  \ 'gutter':  ['fg', 'fzf_gutter'],
  \ 'prompt':  ['fg', 'fzf_prompt'],
  \ 'pointer': ['fg', 'fzf_pointer']
  \}

