CURRENT_FOLDER:=$(shell pwd)
HOME_DIR=$(shell echo $$HOME)
NVIM=$(HOME_DIR)/.config/nvim
XCODE_SNIPPETS:=$(HOME_DIR)/Library/Developer/Xcode/UserData/CodeSnippets

.PHONY: all
all: $(NVIM) $(XCODE_SNIPPETS)

$(NVIM): $(CURRENT_FOLDER)/nvim
	ln -sf $< $@

$(XCODE_SNIPPETS): $(CURRENT_FOLDER)/xcode-snippets
	ln -sf $< $@

.PHONY: clean
clean:
	rm $(NVIM) $(XCODE_SNIPPETS)
