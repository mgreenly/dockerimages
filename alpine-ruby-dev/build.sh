#!/bin/bash

#
# Automation to build and upload this docker image. 
#

#
# make sure the base is current
#
docker pull alpine:latest

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/alpine-ruby-dev | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/alpine-ruby-dev | grep latest | cut -f1 -d:)

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build -t mgreenly/alpine-ruby-dev:$newtag .
docker tag mgreenly/alpine-ruby-dev:"$newtag" mgreenly/alpine-ruby-dev:latest

if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/alpine-ruby-dev:$oldtag
fi


#
# upload the new latest
#
#docker push mgreenly/alpine-ruby-dev:latest
