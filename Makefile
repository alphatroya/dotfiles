CURRENT_FOLDER:=$(shell pwd)
NVIM:=~/.config/nvim
IDEAVIMRC:=~/.ideavimrc
KITTY:=~/.config/kitty
ANTIGEN_SCRIPT=$(CURRENT_FOLDER)/zsh/antigen.zsh
FZF=~/.fzf.zsh
SNIPPETS:=~/.vsnip
XCODE_SNIPPETS:=~/Library/Developer/Xcode/UserData/CodeSnippets

.PHONY: all
all: $(NVIM) $(IDEAVIMRC) $(ANTIGEN_SCRIPT) $(SNIPPETS) $(KITTY) $(XCODE_SNIPPETS)
	cd git && make

$(SNIPPETS): $(CURRENT_FOLDER)/snippets
	ln -sf $< $@

$(NVIM): $(CURRENT_FOLDER)/nvim
	git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	ln -sf $< $@

$(IDEAVIMRC): $(CURRENT_FOLDER)/ideavim/.ideavimrc
	ln -sf $< $@

$(KITTY): $(CURRENT_FOLDER)/kitty
	@echo 'Current kitty config uses GoMono Nerd Font, you should download and install it from here: https://www.nerdfonts.com/font-downloads'
	ln -sf $< $@

$(FZF):
	$(brew --prefix)/opt/fzf/install

$(ANTIGEN_SCRIPT): $(FZF)
	curl -L git.io/antigen > $@
	echo "source ${PWD}"/zsh/antigen.zsh >> ~/.zshrc
	echo "source ${PWD}"/zsh/antigen >> ~/.zshrc
	echo "source ${PWD}"/zsh/aliases >> ~/.zshrc
	echo "source ${PWD}"/zsh/common >> ~/.zshrc

$(XCODE_SNIPPETS): $(CURRENT_FOLDER)/xcode-snippets
	ln -sf $< $@

.PHONY: brew
brew:
	brew bundle check || brew bundle
