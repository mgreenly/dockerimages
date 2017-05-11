#!/bin/bash

#
# fail if any variable is unset
#
set -u

#
# the image we're going to build
#
IMAGE_NAME="mgreenly/alpine-ruby"

#
# define the version info
#
export ALPINE_VERSION="3.5"
export RUBY_MAJOR="2.4"
export RUBY_VERSION="2.4.1"
export RUBY_DOWNLOAD_SHA256="4fc8a9992de3e90191de369270ea4b6c1b171b7941743614cc50822ddc1fe654"
export RUBYGEMS_VERSION="2.6.12"
export BUNDLER_VERSION="1.14.6"

#
# display the version info
#
echo "          RUBY_MAJOR: $RUBY_MAJOR"
echo "        RUBY_VERSION: $RUBY_VERSION"
echo "RUBY_DOWNLOAD_SHA256: $RUBY_DOWNLOAD_SHA256"
echo "    RUBYGEMS_VERSION: $RUBYGEMS_VERSION"
echo "     BUNDLER_VERSION: $BUNDLER_VERSION"
source ../versions.sh

#
# then construct the Dockerfile
#
envsubst < Dockerfile.tmpl > Dockerfile

docker build \
  -t "$IMAGE_NAME":"$RUBY_VERSION" \
  .

#
# set the latest tag
#
docker tag \
  "$IMAGE_NAME":"$RUBY_VERSION" \
  "$IMAGE_NAME":latest

#
# push the image
#
docker push "$IMAGE_NAME":"$RUBY_VERSION"
docker push "$IMAGE_NAME":latest
