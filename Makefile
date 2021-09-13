CURRENT_FOLDER:=$(shell pwd)
NVIM:=~/.config/nvim
IDEAVIMRC:=~/.ideavimrc
ALACRITTY:=~/.config/alacritty/alacritty.yml
ANTIGEN_SCRIPT=$(CURRENT_FOLDER)/zsh/antigen.zsh
FZF=~/.fzf.zsh
SNIPPETS:=~/.vsnip

.PHONY: all
all: $(NVIM) $(IDEAVIMRC) $(ALACRITTY) $(ANTIGEN_SCRIPT) $(SNIPPETS)
	cd git && make

$(SNIPPETS): $(CURRENT_FOLDER)/snippets
	ln -sf $< $@

$(NVIM): $(CURRENT_FOLDER)/nvim
	git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	ln -sf $< $@

$(IDEAVIMRC): $(CURRENT_FOLDER)/ideavim/.ideavimrc
	ln -sf $< $@

$(ALACRITTY): $(CURRENT_FOLDER)/alacritty/alacritty.yml
	@echo 'Current alacritty config uses GoMono Nerd Font, you should download and install it from here: https://www.nerdfonts.com/font-downloads'
	mkdir -p ~/.config/alacritty
	ln -sf $< $@

$(FZF):
	$(brew --prefix)/opt/fzf/install

$(ANTIGEN_SCRIPT): $(FZF)
	curl -L git.io/antigen > $@
	echo "source ${PWD}"/zsh/antigen.zsh >> ~/.zshrc
	echo "source ${PWD}"/zsh/antigen >> ~/.zshrc
	echo "source ${PWD}"/zsh/aliases >> ~/.zshrc
	echo "source ${PWD}"/zsh/common >> ~/.zshrc

.PHONY: brew
brew:
	brew bundle check || brew bundle
