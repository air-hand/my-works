include ../../base-tools/common.mk

.DEFAULT_GOAL := all

ifeq ($(IS_IN_CONTAINER),0)

.PHONY: post-start-devcontainer
post-start-devcontainer:
	COMP_INSTALL=1 COMP_YES=1 gocomplete || true
	while sleep 1s; d
	aqua i || true

all: build run

.PHONY: prebuild
prebuild:
	cd ./app && go get

.PHONY: build
build: prebuild
	cd ./app && go build

.PHONY: run
run:
#	cd ./app && ./app.bin
	cd ./app && GH_TOKEN=$$(gh auth token) go run main.go

else

WORKSPACE_FOLDER_ARG := --workspace-folder=.
DEVCONTAINER_SERVICE := dev
CONTAINER_WORKSPACE := /work/ws/github

MAKE := $(MAKE) --no-print-directory

all : up

.PHONY: init
init:
	@$(MAKE) init-devcontainer && $(MAKE) -B Dockerfile

.PHONY: build
build: init
	devcontainer build $(WORKSPACE_FOLDER_ARG)

.PHONY: up
up: build
	devcontainer up $(WORKSPACE_FOLDER_ARG)

.PHONY: bash
bash:
#	devcontainer exec $(WORKSPACE_FOLDER_ARG) /bin/bash --login -c 'cd /work/ws/github; exec bash'
	docker compose exec $(DEVCONTAINER_SERVICE) /bin/bash -l -c 'cd $(CONTAINER_WORKSPACE); exec bash'

# TODO: devcontainer not supports stop/down yet https://github.com/devcontainers/cli#context
.PHONY: stop
stop:
	docker compose stop

.PHONY: down
down:
	docker compose down --rmi local --remove-orphans --volumes

endif
