#!/bin/sh

docker run --rm -v "$(pwd)":/app -w /app weastur/metalinter:latest ./test.sh