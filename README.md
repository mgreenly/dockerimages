# Docker Images

A collection of docker images


## Some Helpful Commands

```
# remove untagged images
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
# run image interactively
docker run -i -t mgreenly/jessie /bin/bash
# stop all running containers
docker stop $(docker ps -a -q)
# remove all containers
docker rm $(docker ps -a -q)
# remove all containers with some word 'ruby' in there descriptio
docker rm $(docker ps -a | grep "ruby" | awk "{print \$1}")
# remove all images with some word in the description
docker rmi -f $(docker images | grep hello | awk "{print \$3}")
```


