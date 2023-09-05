include ../../base-tools/common.mk

.DEFAULT_GOAL := all

ifeq ($(IS_IN_CONTAINER),0)
else
all : up

.PHONY: build
build: init-devcontainer Dockerfile
	docker compose build

.PHONY: up
up: build
	docker compose up

.PHONY: stop
stop:
	docker compose stop

.PHONY: down
down:
	docker compose down --rmi local --remove-orphans --volumes

endif
