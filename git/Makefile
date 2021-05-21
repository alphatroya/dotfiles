CURRENT_FOLDER:=$(shell pwd)
CONFIG:=~/.gitconfig

.PHONY: all
all: $(CONFIG)

$(CONFIG): $(CURRENT_FOLDER)/root
	git config --global include.path $<

