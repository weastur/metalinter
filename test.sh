#!/bin/sh

printf "test hadolint\n"
hadolint --ignore DL3006 ./tests/Dockerfile
[ $? -eq 1 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test checkmake\n"
checkmake ./tests/Makefile
[ $? -eq 3 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test shellcheck\n"
shellcheck ./tests/run.sh
[ $? -eq 1 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test yamllint\n"
yamllint ./tests/data.yml
[ $? -eq 1 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test markdownlint\n"
markdownlint ./tests/docs.md
[ $? -eq 1 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test jsonlint\n"
jsonlint ./tests/data.json
[ $? -eq 1 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test sqlfluff\n"
sqlfluff lint --dialect postgres ./tests/queries.sql
[ $? -eq 65 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"

printf "test dotenv-linter\n"
dotenv-linter ./tests/.env
[ $? -eq 1 ] || { printf "failed!\n"; exit 1; }
printf "success!\n\n"
