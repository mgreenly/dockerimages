#!/bin/bash

#
# Automation to build and upload this docker image. 
#

#
# make sure the base image is up to date
#
docker pull mgreenly/debian:latest

#
# generate the tag for the new image then build it and tag it 'latest'
#
newtag="2.4"
docker build --no-cache -t mgreenly/debian-ruby:"$newtag" .
docker tag mgreenly/debian-ruby:"$newtag" mgreenly/debian-ruby:latest


#
# upload the new latest
#
docker push mgreenly/debian-ruby:"$newtag"
docker push mgreenly/debian-ruby:latest
