#———————————————————————————————————————————————————————————————————————————————
# HEAD
SHELL := bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:

#———————————————————————————————————————————————————————————————————————————————
# BODY
LISP = sbcl
PROJECT_DIR = $(PWD)
SYSTEM_NAME = adz
BUILD_OUTPUT = adz

.PHONY: all
all: build

.PHONY: build clean 

build:
	$(LISP) --non-interactive \
		--eval '(require :asdf)' \
		--eval '(push #p"$(PROJECT_DIR)/" asdf:*central-registry*)' \
		--eval '(ql:quickload :$(SYSTEM_NAME))' \
		--eval '(asdf:make :$(SYSTEM_NAME))' \
		--eval '(quit)'
	ln -s $(PWD)/adz ~/bin
  
clone: 
	cd ~/common-lisp || cd ~/quicklisp/local-projects && git clone https://github.com/krei-systems/marie.git

clean:
	rm -f $(BUILD_OUTPUT)
	rm -f ~/bin/$(BUILD_OUTPUT)
