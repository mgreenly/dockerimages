# Docker Images

A collection of docker images


## misc

remove untagged images

```
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
``` 
