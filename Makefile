CURRENT_FOLDER:=$(shell pwd)
HOME_DIR := $(shell echo $$HOME)
ANTIGEN_SCRIPT=$(CURRENT_FOLDER)/zsh/antigen.zsh
NVIM:=$(HOME_DIR)/.config/nvim
FZF=$(HOME_DIR)/.fzf.zsh
SNIPPETS:=$(HOME_DIR)/.vsnip
XCODE_SNIPPETS:=$(HOME_DIR)/Library/Developer/Xcode/UserData/CodeSnippets

.PHONY: all
all: $(NVIM) $(ANTIGEN_SCRIPT) $(SNIPPETS) $(XCODE_SNIPPETS) git

.PHONY: git
git: $(CURRENT_FOLDER)/git/root
	git config --global include.path $<

$(SNIPPETS): $(CURRENT_FOLDER)/snippets
	ln -sf $< $@

$(NVIM): $(CURRENT_FOLDER)/nvim
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

.PHONY: clean
clean:
	git config --global --unset include.path
	rm $(NVIM) $(XCODE_SNIPPETS) $(SNIPPETS)

.PHONY: brew
brew:
	brew bundle check || brew bundle
