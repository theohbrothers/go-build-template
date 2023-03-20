#!/bin/sh
set -e
(date -Iseconds; echo gopls) >> ~/date.txt
GOCACHE=/.cache/gocache
GOMODCACHE=/.cache/gomodcache
docker run --rm -i -u $(id -u):$(id -g) -e "GOCACHE=$GOCACHE" -e "GOFLAGS=$GOFLAGS" -w "/src" -v "$PWD:/src" -v "$PWD/.go/cache:/.cache" golang:1.20-alpine go "$@"

