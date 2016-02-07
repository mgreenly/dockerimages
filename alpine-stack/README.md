# alpine-stack


## Introduction

This is a [Docker](https://www.docker.com/) image for [Stack](http://docs.haskellstack.org/en/stable/README.html) based [Haskell](https://www.haskell.org/) development on [Alpine Linux](http://alpinelinux.org/).

It allows you to build very small, 10+ MB, Docker images for Haskell applications.

This is built on [alpine-linux-ghc-bootstrap](https://github.com/mitchty/alpine-linux-ghc-bootstrap).  I didn't do any of the heavy lifting.

## To use this image

Copy the `alpine-stack` script to `~/.local/bin/alpine-stack`, so that it's on your path.

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

The resulting image is a very reasonable 10.23 MB.

```
docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
hello-world             latest              09ddb1842172        57 seconds ago      10.23 MB
```

## Tune for your use

Inevitably you will need to have more or different system packages to compile your application. The
best way to handle this would be to fork this package and edit the included system packages to your
needs.

I believe Haskell statically links all the haskell libraries into the target executable so you will
not have to add additional packages to the base image, beyond the `gmp`, when creating your runtime
image.
