#!/bin/bash

#
# Automation to build and upload this docker image. 
#
IMAGE_NAME="haskell"
FROM_IMAGE="debian"
FROM_TAG="10-slim"
GHC_VER="8.8.4"
CABAL_VER="3.2.0.0"

#
# make sure the base is current
#
docker pull ${FROM_IMAGE}:${FROM_TAG}

#
# get the tag and id of the current image/tag 
#
oldtag=$(docker images --format="{{.ID}}:{{.Tag}}" mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f2 -d:)
oldid=$(docker images --format="{{.ID}}:{{.Tag}}"  mgreenly/$IMAGE_NAME | sort | head -n 1 | cut -f1 -d:)

echo "oldtag: $oldtag"
echo "oldid: $oldid"


# build the new =image tagged as latest
docker build \
  --build-arg GHC_VER=$GHC_VER \
  --build-arg CABAL_VER=$CABAL_VER \
  -t mgreenly/$IMAGE_NAME:latest \
  .

exit

# generate build specific tag and add that tag to the latest build
newtag="$GHC_VER" #-$(date +'%Y%m%d%H%M%S')"
echo $newtag
docker tag mgreenly/$IMAGE_NAME:latest mgreenly/$IMAGE_NAME:$newtag

# if an old tag exists remove it
if [[ -n "$oldtag" ]]; then
  docker rmi mgreenly/$IMAGE_NAME:$oldtag
fi

#
# push the latest images
#
# docker push mgreenly/$IMAGE_NAME:latest
# docker push mgreenly/$IMAGE_NAME:$newtag
