#!/bin/bash

#
# Automation to build and upload this docker image. 
#

#
# make sure the base is current
#
docker pull mitchty/alpine-ghc:latest

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/alpine-stack | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/alpine-stack | grep latest | cut -f1 -d:)

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build -t mgreenly/alpine-stack:$newtag .
docker tag -f mgreenly/alpine-stack:"$newtag" mgreenly/alpine-stack:latest

if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/alpine-stack:$oldtag
fi


#
# upload the new latest
#
#docker push mgreenly/alpine-stack:latest
