#!/bin/bash

#
# Automation to build and upload this docker image. 
#
BUILD="1"

SRC_HOST="registry.digitalocean.com"
SRC_REGISTRY="metaspot"
SRC_IMAGE="debian"
SRC_TAG="11.0-slim_1"
SRC=${SRC_HOST}/${SRC_REGISTRY}/${SRC_IMAGE}:${SRC_TAG}

GHC_VER="8.10.7"
CABAL_VER="3.6.0.0"

DST_HOST="registry.digitalocean.com"
DST_REGISTRY="metaspot"
DST_IMAGE="haskell"
DST_TAG=${GHC_VER}_${BUILD}
DST=${DST_HOST}/${DST_REGISTRY}/${DST_IMAGE}

# make sure the src image is pulled, prevents unlabeled local images
docker pull ${SRC}

# build the specified dst image
docker build \
  --build-arg SRC_HOST=${SRC_HOST} \
  --build-arg SRC_REGISTRY=${SRC_REGISTRY} \
  --build-arg SRC_IMAGE=${SRC_IMAGE} \
  --build-arg SRC_TAG=${SRC_TAG} \
  --build-arg SRC=${SRC} \
  --build-arg GHC_VER=${GHC_VER} \
  --build-arg CABAL_VER=${CABAL_VER} \
  -t ${DST}:${DST_TAG} \
  .

# tag the specified image as latest
docker tag \
  ${DST}:${DST_TAG} \
  ${DST}:latest

# push both the specified and latest tag
docker push $DST:latest
docker push $DST:${DST_TAG}

# save the image to a file
docker save ${DST}:${DST_TAG} | xz -T0 > ${DST_IMAGE}-${DST_TAG}.tar.xz

# backup the image to spaces
s3cmd --progress put ${DST_IMAGE}-${DST_TAG}.tar.xz s3://private-d20-metaspot/images/${DST_IMAGE}-${DST_TAG}.tar.xz
