MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

include ../../../base-tools/dockerfile.mk

.PHONY: init
init:
	@echo "init"
	cd ./cloned && gh repo clone k-tamura/easybuggy4django && \
	cd ./easybuggy4django && rm -rf .git && \
	pip install -r requirements.txt

.PHONY: run
run:
	@cd ./cloned/easybuggy4django && python manage.py runserver
