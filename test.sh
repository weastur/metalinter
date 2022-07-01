#!/bin/sh

docker run --rm -i weastur/metalinter:latest hadolint --ignore DL3006 - < tests/Dockerfile
[ $? -eq 1 ] || exit 1