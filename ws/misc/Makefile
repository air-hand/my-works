MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

include ../../base-tools/dockerfile.mk

.PHONY: centos7-mysql
centos7-mysql:
	docker build -f $(MAKEFILE_DIR)/dockerfiles/Dockerfile.centos7-mysql -t localhost:centos7-mysql .
	docker run --rm -it -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 localhost:centos7-mysql

.PHONY: windbg
windbg:
#	pwsh.exe -Command "Start-Process powershell -Verb RunAs -ArgumentList \"& Start-Service com.docker.service\""
	pwsh.exe -Command 'Start-Process $$Env:ProgramFiles\Docker\Docker\DockerCli.exe -ArgumentList "-SwitchWindowsEngine"'
#	docker.exe build -f $(MAKEFILE_DIR)/dockerfiles/Dockerfile.windbg -t localhost:windbg .
	docker build -f $(MAKEFILE_DIR)/dockerfiles/Dockerfile.windbg -t localhost:windbg .
	docker run --rm -it localhost:windbg
