#!/bin/sh

docker build \
  --no-cache=true \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%S+01:00') \
  --build-arg BUILD_VERSION=0.0.1 \
  -t e3dc-control \
  .