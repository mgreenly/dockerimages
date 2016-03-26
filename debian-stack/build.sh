#!/bin/bash

#
# Automation to build and upload this docker image. 
#

IMAGE_NAME="mgreenly/debian-stack"

#
# make sure the base is current
#
docker pull debian:latest

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" $IMAGE_NAME | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" $IMAGE_NAME | grep latest | cut -f1 -d:)

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build -t $IMAGE_NAME:$newtag .
docker tag $IMAGE_NAME:"$newtag" $IMAGE_NAME:latest

if [[ -n "$oldtag" ]]; then
  docker rmi $IMAGE_NAME:$oldtag
fi


#
# upload the new latest
#
#docker push $IMAGE_NAME:latest
