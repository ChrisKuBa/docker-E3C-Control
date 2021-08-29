#!/bin/sh

docker buildx build \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --no-cache=true \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%S+01:00') \
  --build-arg BUILD_VERSION=0.0.1 \
  -t chriskuba/e3dc-control:latest \
  --push  \
  .