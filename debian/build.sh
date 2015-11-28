#!/bin/bash


oldid=$(docker images mgreenly/debian | tail -n +2 | grep latest | awk "{print \$3}")
tag=$(date +"%Y%m%d%H%M%S")

docker build -t mgreenly/debian:$tag .
newid=$(docker images mgreenly/debian | tail -n +2 | grep $tag | awk "{print \$3}")
docker save $newid | sudo docker-squash -from root -t mgreenly/debian:latest | docker load

echo
echo "OLD=$oldid NEW=$newid"
echo

if [[ $oldid == $newid ]]; then
    echo "same"
    docker rmi mgreenly/debian:$tag
else
    echo "different"
    docker push mgreenly/debian:latest
    docker rmi $oldid
fi
