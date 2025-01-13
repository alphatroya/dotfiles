CURRENT_FOLDER:=$(shell pwd)
HOME_DIR=$(shell echo $$HOME)
ANTIGEN_SCRIPT=$(CURRENT_FOLDER)/zsh/antigen.zsh
NVIM=$(HOME_DIR)/.config/nvim
FISH=$(HOME_DIR)/.config/fish/config.fish
MISE=$(HOME_DIR)/.config/mise/config.toml
XCODE_SNIPPETS:=$(HOME_DIR)/Library/Developer/Xcode/UserData/CodeSnippets

.PHONY: all
all: $(NVIM) $(ANTIGEN_SCRIPT) $(XCODE_SNIPPETS) $(MISE) $(FISH) git

.PHONY: git
git: $(CURRENT_FOLDER)/git
	git config --global include.path $<

$(NVIM): $(CURRENT_FOLDER)/nvim
	ln -sf $< $@

$(FISH): $(CURRENT_FOLDER)/config.fish
	ln -sf $< $@

$(MISE): $(CURRENT_FOLDER)/mise.toml
	ln -sf $< $@
	mise install

$(ANTIGEN_SCRIPT):
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
	rm $(NVIM) $(XCODE_SNIPPETS) $(MISE)

.PHONY: brew
brew:
	brew bundle check || brew bundle
