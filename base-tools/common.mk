COMMON_MK_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ifndef MAKEFILE_DIR
$(error "Must set MAKEFILE_DIR on includer makefile side.")
endif

Dockerfile: $(MAKEFILE_DIR)/Dockerfile.in $(COMMON_MK_DIR)/*
	@cd $(MAKEFILE_DIR) && docker run --rm -it -v $(COMMON_MK_DIR):/base-tools -v $(MAKEFILE_DIR)/:/root:ro coryb/dfpp Dockerfile.in > Dockerfile

.PHONY: init-devcontainer
init-devcontainer:
	@cd $(MAKEFILE_DIR) && \
	PROJECTNAME=$$(basename $(MAKEFILE_DIR)) bash $(COMMON_MK_DIR)/initialize-devcontainer.sh
