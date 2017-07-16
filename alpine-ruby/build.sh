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
export RUBY_VERSION="2.4.1"
export RUBY_DOWNLOAD_SHA256="4fc8a9992de3e90191de369270ea4b6c1b171b7941743614cc50822ddc1fe654"
export RUBYGEMS_VERSION="2.6.12"
export BUNDLER_VERSION="1.15.1"

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
