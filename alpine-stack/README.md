# alpine-stack


## Introduction

This is build on [alpine-linux-ghc-bootstrap](https://github.com/mitchty/alpine-linux-ghc-bootstrap)

The `build` script plus the Dockerfile create the [mgreenly/alpine-stack](https://hub.docker.com/r/mgreenly/alpine-stack/) docker image.

This is a development environment for GHC 7.10.3 that includes Stack.


## How I use this

Copy the `alpine-stack` script to `~/.local/bin/alpine-stack`.  This script is just a wrappper around
the image so you can run it like a normal stack command.

Then use the command `alpine-stack` anywhere you would have used `stack`.

## Example

Build a simple hello world program.

```
alpine-stack new hello-world simple
cd hello-world
alpine-stack build
```

Create a `Dockefile` like this.

```
FROM alpine:latest

ADD .stack-work/install/x86_64-linux/lts-5.1/7.10.3/bin /main

RUN apk update && apk add gmp

CMD /main/hello-world
```

Then build your application image.

```
docker build -t hello-world .
```

Then run the application image

docker run hello-world
