#!/bin/bash


oldid=$(docker images mgreenly/ruby | tail -n +2 | grep latest | awk "{print \$3}")
tag=$(date +"%Y%m%d%H%M%S")

docker build -t mgreenly/ruby:$tag .
newid=$(docker images mgreenly/ruby | tail -n +2 | grep $tag | awk "{print \$3}")
docker save $newid | sudo docker-squash -from root -t mgreenly/ruby:latest | docker load

if [[ $oldid == $newid ]]; then
    echo "remove mgreenly/ruby:$tag"
    docker rmi mgreenly/ruby:$tag
else
    echo "push mgreenly/ruby:latest"
    docker push mgreenly/ruby:latest
    docker rmi $oldid
fi
