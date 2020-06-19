" These settings are added for vim. They are defaults in nvim.
" See :help nvim-defaults
"     a few of these are skipped or changed/directly put in init.vim
" See also: https://www.rosipov.com/blog/sane-vim-defaults-from-neovim/

set nocompatible            " use vim not vi defaults
set autoindent              " copy indent on current line when starting next line
set autoread                " reload file changed outside of vim (thats not yet changed in vim)
set backspace=indent,eol,start  " or backspace=2 on 5.4 and older
set belloff=all             " turn off the nofication bell
set complete-=i             " don't search 'included files' for completion.
set cscopeverbose           " for cscope databases
set display=lastline,msgsep " deals long messages or last lines
set encoding=utf-8          " sets how vim represents chars internally
set fillchars=vert:│,fold:· " characters for vertical splits and folds
set nofsync                 " turn off fsync
set history=10000           " lines of history to remember
set incsearch               " do incremental seraching as you type
set hlsearch                " highlight what you're searching for
set langnoremap
set nolangremap
set laststatus=2             " alsways use status line in position 2
set listchars=tab:> ,trail:-,nbsp:+ " strings to use in list mode for :list command
set nrformats=bin,hex        " #s sarting with 0b 0B are binary, 0x 0X are hex.
set ruler                    " show the cursor position all the time
set sessionoptions-=options  " don't add all options and mappings
set shortmess=filnxtToOF     " avoid 'hit enter' prompts from file msgs
set showcmd                  " show command on last line of screen + visual
set sidescroll=1             " for no wrap, scroll cols when moving right
set smarttab                 " neovim's default
set tabpagemax=50            " neovim's default; used with -p option
set tags=./tags;,tags        " tags files
set ttimeoutlen=50           " time in ms to wait for a key code sequence to complete
set ttyfast                  " fast terminal
set wildmenu                 " ...wildmenu
set wildoptions=pum,tagfile  " changes how cmdline-completion is done
