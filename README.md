# My dotfile configurations files

## Installation

To place all symlinks just call `make`.

## Tool config descriptions

### alacritty

To manually install config place a symlink to `alacritty.yml` file in
`~/.config/alacritty/alacritty.yml` folder. Create folder if needed.

### git

Call `make` to create root config reference in the ~/.gitconfig file.
Additionally you can create `git/private` file with private configuration like this:

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
