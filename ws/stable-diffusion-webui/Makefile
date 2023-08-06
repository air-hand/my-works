include ../../base-tools/common.mk

DOCKER_COMPOSE_RUN_CMD := docker compose run --rm --workdir /work/ws/stable-diffusion-webui --build dev 

.DEFAULT_GOAL := all

all: run

.PHONY: run
run:
ifeq ($(IS_IN_CONTAINER),0)
	bash -x startup.sh
else
	$(DOCKER_COMPOSE_RUN_CMD) $(MAKE) $@
endif

.PHONY: clean
clean:
	docker compose down --rmi all --remove-orphans

.PHONY: test-nvidia-container
test-nvidia-container:
ifeq ($(IS_IN_CONTAINER),0)
	nvidia-smi
else
	$(DOCKER_COMPOSE_RUN_CMD) $(MAKE) $@
endif
