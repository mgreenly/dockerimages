#!/bin/bash

#
# Automation to build and upload this docker image. 
#
IMAGE_NAME="rust"
FROM_TAG="1.38.0-buster"

#
# make sure the base is current
#
docker pull "$IMAGE_NAME:$FROM_TAG"


#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}"  mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f1 -d:)

# build the new =image tagged as latest
docker build \
  -t mgreenly/$IMAGE_NAME:latest \
  .

# generate build specific tag and add that tag to the latest build
docker tag mgreenly/$IMAGE_NAME:latest mgreenly/$IMAGE_NAME:$FROM_TAG

# if an old tag exists remove it
if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/$IMAGE_NAME:$oldtag
fi

#
# push the latest images
#
docker push mgreenly/$IMAGE_NAME:latest
docker push mgreenly/$IMAGE_NAME:$FROM_TAG
