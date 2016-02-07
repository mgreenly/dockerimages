# alpine-stack


## Introduction

This is built on [alpine-linux-ghc-bootstrap](https://github.com/mitchty/alpine-linux-ghc-bootstrap).

The **build.sh** script and the **Dockerfile** are used to create [mgreenly/alpine-stack](https://hub.docker.com/r/mgreenly/alpine-stack/).

The **alpine-stack** image is a [GHC 7.10.3](https://www.haskell.org/) based [Stack](http://docs.haskellstack.org/en/stable/README.html) development environment for [Alpine Linux](http://alpinelinux.org/).


## How I use this

I copy the `alpine-stack` script to `~/.local/bin/alpine-stack`, so that it's on my path.

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

Then run the image.

```
docker run hello-world
```

The image is a very reasonable 10.23 MB.

```
docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
hello-world             latest              09ddb1842172        57 seconds ago      10.23 MB
```
