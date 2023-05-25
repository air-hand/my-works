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
#	codeql database analyze $(CODEQL_DB_PATH) --format=csv --output=./ql/easybuggy4django-db.csv
	codeql database analyze $(CODEQL_DB_PATH) --format=sarifv2.1.0 --output=./ql/easybuggy4django-db.sarif --sarif-add-file-contents
	python3 -m sarif html -o ./ql/summary.html ./ql/easybuggy4django-db.sarif
#	codeql database analyze $(CODEQL_DB_PATH) --format=dot --output=./ql/easybuggy4django-db.dot
