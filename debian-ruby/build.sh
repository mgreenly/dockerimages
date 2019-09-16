#!/bin/bash

#
# Automation to build and upload this docker image. 
#
IMAGE_NAME="ruby"

#
# make sure the base is current
#
docker pull ruby:2.6.4-stetch
#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}"  mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f1 -d:)

# build the new =image tagged as latest
docker build -t mgreenly/$IMAGE_NAME:latest .

# generate build specific tag and add that tag to the latest build
newtag="2.6.4-stretch-$(date +'%Y%m%d%H%M%S')"
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
