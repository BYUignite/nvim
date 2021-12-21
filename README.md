## Installation
```
brew install --HEAD luajit
brew install --HEAD neovim
brew install node
npm  install -g neovim
brew install nvr                                                       # for vimtex
pip install pynvim
echo 'export BAT_THEME=ansi' >> ~/.bashrc

#--- lsp servers (language servers)
brew install llvm                                                      # clang (c++)
pip install -U jedi-language-server                                    # python
pip install fortran-language-server                                    # fortran
brew install rust;                                                     # for cargo, for latex
cargo install --git https://github.com/latex-lsp/texlab.git --locked   # latex
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile

#--- aliases, variables
echo 'alias vim="nvim"' >> ~/.bashrc
echo 'alias vg="nvim -d"' >> ~/.bashrc
echo 'alias vimdiff="nvim -d"' >> ~/.bashrc
echo 'export GIT_EDITOR=nvim' >> ~/.bashrc

#--- Create folder ~/.config/nvim
mkdir ~/.config/nvim

#--- open neovim, this will create/download ~/.config/nvim/autoload/plug.vim and install plugins
vim ~/.config/nvim/init.vim

#--- copy colorscheme if not using one that comes with the airline-themes plugin
cp colors/dol_airline_2.vim plugged/vim-airline-themes/autoload/airline/themes/

```


## Some helpful notes

* To increment a number do <C-a>. To make a list of increasing numbers: make column of zeros, highlight in visual mode, then g<C-a>

* :set formatoptions? to see value of variable formatoptions, or whatever
* :verbose set variable? to see where variable last set.

* <C-o>, <C-i>  --> jump back and forward (e.g., through tags)

* :h CTRL-u  --> brings up help for typing <C-u> or "control u" in normal mode
* :h c_CTRL-u --> brings up help for type <C-u> in command mode.

* :h nvim-defaults

* https://superuser.com/questions/220666/how-do-you-reuse-a-visual-mode-selection
* use gv to recover the previous visual selection. This is really useful when running the visual selection through python.

