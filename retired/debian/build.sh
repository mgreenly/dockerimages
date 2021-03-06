#!/bin/bash

#
# Automation to build and upload this docker image. 
#

#
# make sure the base is current
#
docker pull debian:latest

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/debian | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/debian | grep latest | cut -f1 -d:)

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build --no-cache -t mgreenly/debian:$newtag .
docker tag mgreenly/debian:"$newtag" mgreenly/debian:latest

if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/debian:$oldtag
fi


#
# upload the new latest
#
docker push mgreenly/debian:latest
