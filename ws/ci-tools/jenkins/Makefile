include ../../../base-tools/common.mk

.DEFAULT_GOAL := all

ifeq ($(IS_IN_CONTAINER),0)

JENKINS_URL := http://jenkins
JENKINS_CMD ?= help

all: jenkins-cli

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

all : up

.PHONY: build
build: Dockerfile
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
