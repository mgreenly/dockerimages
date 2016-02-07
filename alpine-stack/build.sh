#!/bin/bash

#
# make sure the base is current
#
docker pull mitchty/alpine-ghc:latest

#
# get the id of the current image
#
oldid=$(docker images mgreenly/alpine-stack | tail -n +2 | grep latest | awk "{print \$3}")

#
# generate the tag for the new image and build it also tag it latest
#
tag=$(date +"%Y%m%d%H%M%S")
docker build -t mgreenly/alpine-stack:$tag .
newid=$(docker images mgreenly/alpine-stack | tail -n +2 | grep $tag | awk "{print \$3}")
docker tag -f "$newid" mgreenly/alpine-stack:latest

#
# upload the new latest
#
docker push mgreenly/alpine-stack:latest

if [[ $oldid == $newid ]]; then
    # 
    # remove the new tagged image.  there's no point
    # in having multiple tags matching the latest image
    #
    docker rmi mgreenly/alpine-stack:$tag
else
    #
    # only keep the most recent versions
    #
    if [[ -n "$oldid" ]]; then
      docker rmi $oldid
    fi
fi

