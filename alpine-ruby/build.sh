#!/bin/bash

#
# fail if any variable is unset
#
set -u



#
# define all the component versions used in building this image
#
export ALPINE_VERSION="3.6"
export RUBY_MAJOR="2.4"
export RUBY_VERSION="2.4.2"
export RUBY_DOWNLOAD_SHA256="748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735"
export RUBYGEMS_VERSION="2.6.14"
export BUNDLER_VERSION="1.16.0"

#
# the images name/tag info
#
IMAGE_NAME="mgreenly/ruby"
TIME=$(date +"%Y%m%d%H%M%S")
IMAGE_TAG="${RUBY_VERSION}-alpine_${TIME}"

#
# display the version info
#
echo -e "\n${IMAGE_NAME}:${IMAGE_TAG}...\n"
echo "      ALPINE_VERSION: $ALPINE_VERSION"
echo "          RUBY_MAJOR: $RUBY_MAJOR"
echo "        RUBY_VERSION: $RUBY_VERSION"
echo "RUBY_DOWNLOAD_SHA256: $RUBY_DOWNLOAD_SHA256"
echo "    RUBYGEMS_VERSION: $RUBYGEMS_VERSION"
echo "     BUNDLER_VERSION: $BUNDLER_VERSION"
echo "          IMAGE_NAME: $IMAGE_NAME"
echo "                TIME: $TIME"
echo "           IMAGE_TAG: $IMAGE_TAG"

#
# construct the docker file with this version info
#
envsubst < Dockerfile.tmpl > Dockerfile

#
# build the docker image
#
docker build \
  --no-cache \
  -t "$IMAGE_NAME":"$IMAGE_TAG" \
  .

#
# set the latest tag
#
docker tag \
  "$IMAGE_NAME":"$IMAGE_TAG" \
  "$IMAGE_NAME":latest

#
# push the image
#
docker push "$IMAGE_NAME":"$IMAGE_TAG"
docker push "$IMAGE_NAME":latest
