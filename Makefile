MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
WORKSPACES := $(MAKEFILE_DIR)/ws

NEW_WS := ""

.PHONY: new-ws
new-ws:
	@test -z $(NEW_WS) || exit 1; \
	echo "creating workspace: $(NEW_WS) ..." \
	mkdir -p $(NEW_WS); 
