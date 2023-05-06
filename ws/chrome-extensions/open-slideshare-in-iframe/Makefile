all: install build

.PHONY: install
install:
	npm install

.PHONY: clean
clean:
	rm -rf dist

# build(bundle)はparcelに任せるため、watchしつつ、tscのエラーを表示する
.PHONY: watch
watch:
	npx tsc --noEmit --watch

.PHONY: build
build: clean test
	npx tsc --noEmit && npx parcel build manifest.json --no-source-maps

.PHONY: test
test:
	npx jest
