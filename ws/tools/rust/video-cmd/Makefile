MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: build

.PHONY: install-toolchain
install-toolchain:
	rustup target add \
	x86_64-unknown-linux-gnu \
	x86_64-pc-windows-gnu

.PHONY: build
build:
	cargo build

.PHONY: test
test:
	cargo test

.PHONY: clean
clean:
	cargo clean

.PHONY: watch
watch:
	inotifywait -m -e modify -e create -e delete -r $(MAKEFILE_DIR) --format '%T %w %f %e' --timefmt '%F %T' --include ".+?\.(rs)$$" | \
	while read EVENTS; do make build && make test; done \
