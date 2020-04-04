#!/bin/bash

#
# Automation to build and upload this docker image. 
#
IMAGE_NAME="haskell"
FROM_TAG="debian-10.3"
GHC_VER="8.10.1"

#
# make sure the base is current
#
docker pull debian:buster

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}"  mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f1 -d:)

# build the new =image tagged as latest
docker build \
  --build-arg GHC_VER=$GHC_VER \
  -t mgreenly/$IMAGE_NAME:latest \
  .

# generate build specific tag and add that tag to the latest build
newtag="$FROM_TAG-ghc-$GHC_VER" #-$(date +'%Y%m%d%H%M%S')"
echo $newtag
docker tag mgreenly/$IMAGE_NAME:latest mgreenly/$IMAGE_NAME:$newtag

# if an old tag exists remove it
if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/$IMAGE_NAME:$oldtag
fi

#
# push the latest images
#
# docker push mgreenly/$IMAGE_NAME:latest
# docker push mgreenly/$IMAGE_NAME:$newtag
