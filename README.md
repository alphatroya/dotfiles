# My configurations files

## Installation

To place all symlinks just call `make`.

## Tool config descriptions

### git

Call `make` to create root config reference in the ~/.gitconfig file.
Additionally you can append some private info to it.

```git
[user]
	name = <name>
	email = <email>
	signingkey = <signing key ID>
[git-town]
	github-token = <token for GitHub for Git Town tool>
```

Also you may create `~/.gitignore` file for global ignore rules (like `.DS_Store` files in Mac).

### neovim

- Install [vim-plug](https://github.com/junegunn/vim-plug#neovim) plugin manager

- Create symlink to the nvim config folder

```
ln -s $(pwd)/nvim ~/.config/nvim
```

- Call `:PlugInstall` to install required plugins

### zsh

```sh
echo "source ${PWD}"/zsh/aliases >> ~/.zshrc \
echo "source ${PWD}"/zsh/common >> ~/.zshrc \
echo "source ${PWD}"/zsh/antigen >> ~/.zshrc
```
