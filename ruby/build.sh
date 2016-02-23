#!/bin/bash

#
# Automation to build and upload this docker image. 
#

#
# make sure the base is current
#
docker pull mgreenly/debian:latest

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/ruby | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/ruby | grep latest | cut -f1 -d:)

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build -t mgreenly/ruby:$newtag .
docker tag mgreenly/ruby:"$newtag" mgreenly/ruby:latest

if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/ruby:$oldtag
fi


#
# upload the new latest
#
docker push mgreenly/ruby:latest
