IS_IN_CONTAINER := $(shell test -f /.dockerenv && echo 0 || echo 1)
REPO_ROOT_DIR := $(shell git rev-parse --show-toplevel)

# self variables
COMMON_MK_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# includer variables
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

ifeq ($(words $(MAKEFILE_LIST)),1)
$(error "Must include $(firstword $(MAKEFILE_LIST)) from another makefile.")
endif

.PHONY: random-string
random-string:
	@SHELL=/bin/bash cat /dev/urandom |LANG=C tr -dc '[:alnum:]' | head -c 100

.PHONY: show-vars
show-vars:
	@echo "IS_IN_CONTAINER: $(IS_IN_CONTAINER)"
	@echo "REPO_ROOT_DIR: $(REPO_ROOT_DIR)"
	@echo "COMMON_MK_DIR: $(COMMON_MK_DIR)"
	@echo "MAKEFILE_DIR: $(MAKEFILE_DIR)"

Dockerfile: $(MAKEFILE_DIR)/Dockerfile.in $(COMMON_MK_DIR)/*
	@cd $(MAKEFILE_DIR) && docker run --rm -v $(COMMON_MK_DIR):/base-tools -v $(MAKEFILE_DIR)/:/root:ro coryb/dfpp Dockerfile.in > Dockerfile

.PHONY: init-devcontainer
init-devcontainer:
	@cd $(MAKEFILE_DIR) && \
	PROJECTNAME=$$(basename $(MAKEFILE_DIR)) bash $(COMMON_MK_DIR)/initialize-devcontainer.sh
