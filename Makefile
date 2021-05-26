CURRENT_FOLDER:=$(shell pwd)
NVIM:=~/.config/nvim
IDEAVIMRC:=~/.ideavimrc
ALACRITTY:=~/.config/alacritty/alacritty.yml

.PHONY: all
all: $(NVIM) $(IDEAVIMRC) $(ALACRITTY)
	cd git && make

$(NVIM): $(CURRENT_FOLDER)/nvim
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-$$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	ln -sf $< $@

$(IDEAVIMRC): $(CURRENT_FOLDER)/ideavim/.ideavimrc
	ln -sf $< $@

$(ALACRITTY): $(CURRENT_FOLDER)/alacritty/alacritty.yml
	mkdir -p ~/.config/alacritty
	ln -sf $< $@

.PHONY: brew
brew:
	brew bundle check || brew bundle
