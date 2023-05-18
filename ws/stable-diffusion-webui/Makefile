MAKEFILE_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
IS_IN_CONTAINER := $(shell test -f /.dockerenv && echo 0 || echo 1)
DOCKER_COMPOSE_RUN_CMD := docker compose run --rm --workdir /work/ws/stable-diffusion-webui --build dev 

.PHONY: run
run:
	if [ $(IS_IN_CONTAINER) -eq 0 ]; then \
		bash -x startup.sh; \
	else \
		$(DOCKER_COMPOSE_RUN_CMD) $(MAKE) $@; \
	fi

.PHONY: clean
clean:
	docker compose down --rmi all --remove-orphans

.PHONY: test-nvidia-container
test-nvidia-container:
	if [ $(IS_IN_CONTAINER) -eq 0 ]; then \
		nvidia-smi; \
	else \
		$(DOCKER_COMPOSE_RUN_CMD) $(MAKE) $@; \
	fi
