#!/bin/bash

#
# Automation to build and upload this docker image. 
#

#
# make sure the base image is up to date
#
docker pull mgreenly/debian:latest

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/ruby2.4 | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/ruby2.4 | grep latest | cut -f1 -d:)

#
# generate the tag for the new image then build it and tag it 'latest'
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build --no-cache -t mgreenly/ruby2.4:$newtag .
docker tag mgreenly/ruby2.4:"$newtag" mgreenly/ruby2.4:latest

if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/ruby2.4:$oldtag
fi


#
# upload the new latest
#
docker push mgreenly/ruby2.4:latest
