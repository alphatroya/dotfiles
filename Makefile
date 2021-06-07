CURRENT_FOLDER:=$(shell pwd)
NVIM:=~/.config/nvim
IDEAVIMRC:=~/.ideavimrc
ALACRITTY:=~/.config/alacritty/alacritty.yml
ANTIGEN_SCRIPT=$(CURRENT_FOLDER)/zsh/antigen.zsh
FZF=~/.fzf.zsh

.PHONY: all
all: $(NVIM) $(IDEAVIMRC) $(ALACRITTY) $(ANTIGEN_SCRIPT)
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

$(FZF):
	$(brew --prefix)/opt/fzf/install

$(ANTIGEN_SCRIPT): $(FZF)
	curl -L git.io/antigen > $@
	echo "source ${PWD}"/zsh/antigen.zsh >> ~/.zshrc
	echo "source ${PWD}"/zsh/antigen >> ~/.zshrc
	echo "source ${PWD}"/zsh/aliases >> ~/.zshrc
	echo "source ${PWD}"/zsh/common >> ~/.zshrc
	echo "source ${PWD}"/zsh/create-feature >> ~/.zshrc

.PHONY: brew
brew:
	brew bundle check || brew bundle
