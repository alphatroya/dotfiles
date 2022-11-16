# My configurations files

## Installation

```
make
```

## Tool config descriptions

### git

`make git` will add create root config reference to the ~/.gitconfig file.
Also you can create `~/.gitignore` file for global ignore rules (like `.DS_Store` files for MacOS).

### neovim

- Install [vim-plug](https://github.com/junegunn/vim-plug#neovim) plugin manager
- Create symlink to the nvim config folder
```
ln -s $(pwd)/nvim ~/.config/nvim
```

- Call `:PackerSync` to install required plugins

### zsh

```sh
echo "source ${PWD}"/zsh/aliases >> ~/.zshrc \
echo "source ${PWD}"/zsh/common >> ~/.zshrc \
echo "source ${PWD}"/zsh/antigen >> ~/.zshrc
```
