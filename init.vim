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

"---------- denite
highlight denitewindow ctermbg=255 ctermfg=0
highlight denitefilter ctermbg=253 ctermfg=0
highlight deniteprompt ctermbg=253 ctermfg=0
highlight denitetest   ctermbg=255 ctermfg=0
highlight deniteSource_buffer_Name ctermbg=255   ctermfg=0
highlight SignColumn   ctermbg=255 ctermfg=0

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

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }


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


"==================== denite
" See also: https://github.com/ornicar/dotfiles/blob/master/vim/vimrc
"           https://github.com/machty/dotfiles/blob/master/.vimrc

" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

"--- Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

"--- Custom options for ripgrep
"      --vimgrep:  Show results with every match on it's own line
"      --hidden:   Search hidden directories and files
"      --heading:  Show the file name above clusters of matches from each file
"      --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

"--- Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

"--- Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

"--- Custom options for Denite
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': '᯾ ',
\ 'vertical_preview': 1,
\ 'reversed': 1,
\ 'winwidth': &columns *28/30,
\ 'wincol': &columns / 30,
\ 'winheight': 12,
\ 'statusline': 0,
\ 'highlight_matched_char':      'denitetest',
\ 'highlight_matched_range':     'denitetest',
\ 'highlight_window_background': 'denitewindow',
\ 'highlight_filter_background': 'denitefilter',
\ 'highlight_prompt':            'deniteprompt',
\ }}

"--- Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)

" === Denite shorcuts === "

" <leader>b - Browser currently open buffers
" <leader>f - Browse list of files in current directory
" <leader>G - Search current directory for occurences of given term and close window if no results
" <leader>g - Search current directory for occurences of word under cursor
" <leader>t - Jump to tag under word
nmap     <leader>b  :Denite buffer<CR>
nmap     <leader>f  :DeniteProjectDir file/rec<CR>
nnoremap <leader>G  :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>g  :<C-u>DeniteCursorWord grep:.:-w<CR>
nnoremap <leader>T  :<C-u>DeniteCursorWord tag<CR>
"nnoremap <leader>t  :<C-u>DeniteCursorWord -immediately tag<CR><CR>

" Define mappings while in 'filter' mode
"   kk            - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <C-o>         - Open currently selected file in any mode
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> kk        <Plug>(denite_filter_quit)
  nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  inoremap <silent><buffer><expr> <C-o> denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h> denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-o> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  nnoremap <silent><buffer><expr> d     denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p     denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i     denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-i> denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h> denite#do_map('do_action', 'split')
endfunction
