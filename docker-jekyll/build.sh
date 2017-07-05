#!/bin/bash

#
# Automation to build and upload this docker image. 
#


#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/docker-jekyll | grep -v latest | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/docker-jekyll | grep latest | cut -f1 -d:)

echo "oldtag is: $oldtag"
echo "oldid is: $oldid"

#
# generate the tag for the new image and build it also tag it latest
#
newtag=$(date +"%Y%m%d%H%M%S")
docker build -t mgreenly/docker-jekyll:$newtag .
docker tag mgreenly/docker-jekyll:"$newtag" mgreenly/docker-jekyll:latest

if [[ ! -z "$oldtag" ]]; then
  docker rmi mgreenly/docker-jekyll:$oldtag
fi


#
# upload the new latest
#
docker push mgreenly/docker-jekyll:latest
