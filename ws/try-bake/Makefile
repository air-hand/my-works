include ../../base-tools/common.mk

.DEFAULT_GOAL := all

all: build

.PHONY: build
build:
	@docker buildx bake -f env.hcl -f docker-bake.hcl

.PHONY: run
run: build
	@docker run --rm -it try-bake:latest

.PHONY: login
login: build
	@docker run --rm -it try-bake:latest /bin/bash
