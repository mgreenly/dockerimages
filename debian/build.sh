#!/bin/bash

BUILD="1"

SRC_HOST="docker.io"
SRC_REGISTRY="library"
SRC_IMAGE="debian"
SRC_TAG="11.0-slim"
SRC=${SRC_HOST}/${SRC_REGISTRY}/${SRC_IMAGE}:${SRC_TAG}

DST_HOST="registry.digitalocean.com"
DST_REGISTRY="metaspot"
DST_IMAGE="debian"
DST_TAG=${SRC_TAG}_${BUILD}
DST=${DST_HOST}/${DST_REGISTRY}/${DST_IMAGE}

# TODO: abort the build if the dst image already exists.

# make sure the src image is pulled, prevents unlabeled local images
docker pull ${SRC}

# build the specified dst image
docker build \
  --build-arg SRC_HOST=${SRC_HOST} \
  --build-arg SRC_REGISTRY=${SRC_REGISTRY} \
  --build-arg SRC_IMAGE=${SRC_IMAGE} \
  --build-arg SRC_TAG=${SRC_TAG} \
  --build-arg SRC=${SRC} \
  -t ${DST}:${DST_TAG} \
  .

# # tag the specified image as latest
# docker tag \
#   ${DST}:${DST_TAG} \
#   ${DST}:latest

# push both the specified and latest tag
# docker push $DST:latest
docker push $DST:${DST_TAG}
