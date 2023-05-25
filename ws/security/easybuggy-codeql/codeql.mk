# Codeql commands
CODEQL_DB_PATH := ./ql/easybuggy4django-db

.PHONY: codeql-init
codeql-init:
	@echo "codeql-init"
	mkdir -p ./ql
	codeql pack download codeql/python-all
	codeql pack download codeql/python-queries
	codeql database create $(CODEQL_DB_PATH) --language=python --source-root=./cloned/easybuggy4django --overwrite

.PHONY: codeql-analyze
codeql-analyze:
	@echo "codeql-analyze"
	codeql database analyze $(CODEQL_DB_PATH) --format=csv --output=./ql/easybuggy4django-db.csv
