include ../../base-tools/common.mk

.DEFAULT_GOAL := all

ifeq ($(IS_IN_CONTAINER),0)

.PHONY: post-start-devcontainer
post-start-devcontainer:
	COMP_INSTALL=1 COMP_YES=1 gocomplete

all: build run

.PHONY: prebuild
prebuild:
	cd ./src && go get

.PHONY: build
build: prebuild
	cd ./src && go build

.PHONY: run
run:
#	cd ./src && ./app.bin
	cd ./src && GH_TOKEN=$$(gh auth token) go run main.go

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
