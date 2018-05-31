# [Neo-vim](https://neovim.io/) configuration files

## Installation

- Create `~/.config/nvim/init.vim` with those contents:

```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

- Install [vim-plug](https://github.com/junegunn/vim-plug) plugin manager

- Create symlink to the vimrc and vim folder

```
ln -s <path to vimrc file> ~/.vimrc
ln -s <path to nvim folder> ~/.vim
```

- Call `:PlugInstall` inside neovim
