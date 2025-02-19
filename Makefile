CURRENT_FOLDER:=$(shell pwd)
HOME_DIR=$(shell echo $$HOME)
NVIM=$(HOME_DIR)/.config/nvim
FISH=$(HOME_DIR)/.config/fish/config.fish
XCODE_SNIPPETS:=$(HOME_DIR)/Library/Developer/Xcode/UserData/CodeSnippets

.PHONY: all
all: $(NVIM) $(XCODE_SNIPPETS) $(FISH) git

.PHONY: git
git: $(CURRENT_FOLDER)/git
	git config --global include.path $<

$(NVIM): $(CURRENT_FOLDER)/nvim
	ln -sf $< $@

$(FISH): $(CURRENT_FOLDER)/config.fish
	ln -sf $< $@

$(XCODE_SNIPPETS): $(CURRENT_FOLDER)/xcode-snippets
	ln -sf $< $@

.PHONY: clean
clean:
	git config --global --unset include.path
	rm $(NVIM) $(XCODE_SNIPPETS)

.PHONY: brew
brew:
	brew bundle check || brew bundle
