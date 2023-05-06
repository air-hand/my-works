DOCKERFILE_MK_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

ifndef MAKEFILE_DIR
$(error "Must set MAKEFILE_DIR on includer makefile side.")
endif

Dockerfile: $(MAKEFILE_DIR)/Dockerfile.in $(DOCKERFILE_MK_DIR)/*
	@cd $(MAKEFILE_DIR) && docker run --rm -i -v $(DOCKERFILE_MK_DIR):/base-tools -v ./:/root:ro coryb/dfpp Dockerfile.in > Dockerfile
