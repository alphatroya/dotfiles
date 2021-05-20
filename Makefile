CURRENT_FOLDER:=$(shell pwd)
NVIM:=~/.config/nvim
IDEAVIMRC:=~/.ideavimrc
ALACRITTY:=~/.config/alacritty/alacritty.yml

.PHONY: all
all: $(NVIM) $(IDEAVIMRC) $(ALACRITTY)

$(NVIM): $(CURRENT_FOLDER)/nvim
	ln -sf $< $@

$(IDEAVIMRC): $(CURRENT_FOLDER)/ideavim/.ideavimrc
	ln -sf $< $@

$(ALACRITTY): $(CURRENT_FOLDER)/alacritty/alacritty.yml
	mkdir -p ~/.config/alacritty
	ln -sf $< $@

.PHONY: brew
brew:
	brew bundle check || brew bundle
