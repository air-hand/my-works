IS_IN_CONTAINER := $(shell test -f /.dockerenv && echo 0 || echo 1)
REPO_ROOT_DIR := $(shell git rev-parse --show-toplevel)

# self variables
COMMON_MK_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# includer variables
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

ifeq ($(words $(MAKEFILE_LIST)),1)
$(error "Must include $(firstword $(MAKEFILE_LIST)) from another makefile.")
endif

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

.PHONY: devcontainer-up
devcontainer-up: DOTFILES_GITHUB_REPOSITORY ?=
devcontainer-up: DOTFILES_REPOSITORY_URL ?=
devcontainer-up: DOTFILES_REPOSITORY_URL := $(if $(DOTFILES_GITHUB_REPOSITORY:=),https://github.com/$(DOTFILES_GITHUB_REPOSITORY),$(DOTFILES_REPOSITORY_URL))
devcontainer-up: DEVCONTAINER_ARGS ?= --workspace-folder=./ --remove-existing-container
devcontainer-up: DEVCONTAINER_ARGS := $(if $(DOTFILES_REPOSITORY_URL:=),$(DEVCONTAINER_ARGS) --dotfiles-repository=$(DOTFILES_REPOSITORY_URL),$(DEVCONTAINER_ARGS))
devcontainer-up:
	@if [ -z "$(DOTFILES_GITHUB_REPOSITORY)" ]; then \
		echo "DOTFILES_GITHUB_REPOSITORY is not set. set it to the owner/repo of your dotfiles repository if you want to use."; \
		echo "e.g."; \
		echo "	make devcontainer-up DOTFILES_REPOSITORY_URL=https://path/to/your/dotfiles.git"; \
		echo "	make devcontainer-up DOTFILES_GITHUB_REPOSITORY=owner/dotfiles_repo"; \
	fi; \
	cd $(MAKEFILE_DIR) && \
	devcontainer up $(DEVCONTAINER_ARGS)
