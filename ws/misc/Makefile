MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

include ../../base-tools/dockerfile.mk

.PHONY: centos7-mysql
centos7-mysql:
	docker build -f $(MAKEFILE_DIR)/dockerfiles/Dockerfile.centos7-mysql -t localhost:centos7-mysql .
	docker run --rm -it -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 localhost:centos7-mysql
