#!/bin/sh

docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --no-cache=true \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%S+01:00') \
  --build-arg BUILD_VERSION=$(git describe --tags) \
  --build-arg REVISION=$(git log -1 --format=%H) \
  -t chriskuba/e3dc-control:$(git describe --tags) \
  -t chriskuba/e3dc-control:latest \
  --push  \
  .
