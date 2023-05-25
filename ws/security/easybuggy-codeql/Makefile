MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

include ../../../base-tools/dockerfile.mk

.PHONY: init
init:
	@echo "init"
	cd ./cloned && rm -rf easybuggy4django \
	&& git clone https://github.com/k-tamura/easybuggy4django.git \
	&& cd ./easybuggy4django && rm -rf .git \
	&& sed -i -e "/^urllib3/d" requirements.txt \
	&& cp $(MAKEFILE_DIR)/only_vulnerable_settings.py ./config/

# python3.6が必要なので、DooDで別途コンテナを立てる
define EASYBUGGY_DOCKERFILE
FROM python:3.6

RUN apt-get update && apt-get install -y \
	gcc \
	python3-dev \
	python3-pip \
	zlib1g-dev \
	libjpeg-dev \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN python3 -m pip install -U pip && python3 -m pip install -r requirements.txt

COPY . ./
endef
export EASYBUGGY_DOCKERFILE

.PHONY: build
build:
	@cd ./cloned/easybuggy4django && echo "$$EASYBUGGY_DOCKERFILE" | docker build -t easybuggy4django:latest -f- .

.PHONY: run
run: build
	@cd ./cloned/easybuggy4django \
	&& docker run --rm -it --name easybuggy4django-container --env DJANGO_SETTINGS_MODULE=config.only_vulnerable_settings -p 8000:8000 easybuggy4django:latest \
	python manage.py runserver 0.0.0.0:8000

.PHONY: devcontainer-test
devcontainer-test:
	devcontainer up --workspace-folder=./ --remove-existing-container
