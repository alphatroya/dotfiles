CURRENT_FOLDER:=$(shell pwd)
HOME_DIR=$(shell echo $$HOME)
NVIM=$(HOME_DIR)/.config/nvim

.PHONY: all
all: $(NVIM)

$(NVIM): $(CURRENT_FOLDER)/nvim
	ln -sf $< $@

.PHONY: clean
clean:
	rm $(NVIM)
