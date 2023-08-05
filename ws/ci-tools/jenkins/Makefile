MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))
IS_IN_CONTAINER := $(shell test -f /.dockerenv && echo 0 || echo 1)
ROOT_DIR := $(shell while ! test -f .root; do cd ..; done && echo $$(pwd))

include $(ROOT_DIR)/base-tools/common.mk

ifeq ($(IS_IN_CONTAINER),0)

JENKINS_URL := http://jenkins
JENKINS_CMD ?= help

.PHONY: download-jenkins-cli
download-jenkins-cli:
	@curl -sO $(JENKINS_URL)/jnlpJars/jenkins-cli.jar

.PHONY: jenkins-cli
jenkins-cli: download-jenkins-cli
	@java -jar jenkins-cli.jar -s $(JENKINS_URL) -auth admin:admin $(JENKINS_CMD)

.PHONY: clean-jenkins
clean-jenkins:
	@sudo rm -rf /var/jenkins_home/*

else

.PHONY: build
build:
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
