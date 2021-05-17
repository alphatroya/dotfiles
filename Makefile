CURRENT_FOLDER:=$(shell pwd)
VIMRC:=~/.vimrc
VIMF:=~/.vim
IDEAVIMRC:=~/.ideavimrc
ALACRITTY:=~/.config/alacritty/alacritty.yml

.PHONY:
all: $(VIMF) $(VIMRC) $(IDEAVIMRC) $(ALACRITTY)

$(VIMF): $(CURRENT_FOLDER)/nvim
	ln -sf $< $@

$(VIMRC): $(CURRENT_FOLDER)/nvim/vimrc
	ln -sf $< $@

$(IDEAVIMRC): $(CURRENT_FOLDER)/ideavim/.ideavimrc
	ln -sf $< $@

$(ALACRITTY): $(CURRENT_FOLDER)/alacritty/alacritty.yml
	ln -sf $< $@
