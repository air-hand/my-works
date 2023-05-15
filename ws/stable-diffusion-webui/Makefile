MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

include ../../base-tools/dockerfile.mk

.PHONY: run
run: Dockerfile
	docker compose run --rm --workdir /work/ws/stable-diffusion-webui --build dev bash -x startup.sh

.PHONY: clean
clean:
	docker compose down --rmi all --remove-orphans

.PHONY: test-nvidia-container
test-nvidia-container:
	docker compose run --rm --workdir /work/ws/stable-diffusion-webui dev nvidia-smi

# https://zenn.dev/takeguchi/articles/361e12a5321095
# FROM nvidia/cuda:11.7.0-base-ubuntu22.04
# FROM nvidia/cuda:12.1.1-base-ubuntu22.04

