# syntax=docker/dockerfile:1
FROM golang:1.20-alpine

ENV GOCACHE=/.cache/gocache
ENV GOMODCACHE=/.cache/gomodcache
RUN --mount=type=bind,target=/src \
    --mount=type=bind,source=.go/cache/gocache,target=/.cache/gocache \
    --mount=type=bind,source=.go/cache/gomodcache,target=/.cache/gomodcache \
    go install github.com/go-delve/delve/cmd/dlv@v1.20.1; \
    go install golang.org/x/tools/gopls@v0.11.0;
WORKDIR /src
RUN --mount=type=bind,target=/src \
    --mount=type=bind,source=.go/cache/gocache,target=/.cache/gocache \
    --mount=type=bind,source=.go/cache/gomodcache,target=/.cache/gomodcache \
    OS=$( go env GOOS ) ARCH=$( go env GOARCH ) VERSION=123 ./build/build.sh ./...
CMD [ "myapp-1" ]
