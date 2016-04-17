# alpine-stack


## Introduction

This is a [Docker](https://www.docker.com/) image for a [Stack](http://docs.haskellstack.org/en/stable/README.html) based [Haskell](https://www.haskell.org/) development environment on [Alpine Linux](http://alpinelinux.org/).

It allows you to build very small Docker images for Stack based Haskell applications.

Approximately 7MB for a typical hello world application vs 137MB for the same application on debian stable.

This is built on [alpine-linux-ghc-bootstrap](https://github.com/mitchty/alpine-linux-ghc-bootstrap).  I didn't do any of the heavy lifting.  [Mitchty](https://github.com/mitchty/) deserves all the credit.  I just tried to put his hardwork to good use.

## How To Use This

There are two scripts in the bin directory.  Add both to your $HOME/.local/bin directory.

Inside the directory of your stack project run `alpine-dockerize`.

The dockerize script generates a 'Dockerfile'.  The  dockerize script is pretty dumb.  It assumes there's only a single executable defined in the cabal files and generates the necessary commands to copy it into the image.  It's purpose is to provdie a baseline you can evolve.

The dockerize script also generates a 'build.sh' script.  This scripts purpose is to reduce the build process to a single command `./build'.  Delete it if you don't want it.

After running the dockerize script just run `.\build.sh` to build the image.

## Example.

Doing this for a hello-world application may look like this.

```
stack new hello-world                         # create new stack project
cd hello-world                                # enter project
alpine-dockerize                              # create docker/build.sh scripts
alpine-stack build                            # build manually
docker build -t mgreenly/hello-world .        # create image manually
docker run mgreenly/hello-world               # run the image
```


## How things work

The `mgreenly/alpine-stack` image is only the development environment.  It has stack, ghc and ghci as well as many common libraries installed on it.  It's big, approximately 1.2GB but it only needs to exist on the development machine.

The `alpine-stack` script simply runs that docker image, mounts the local project directory for it and passes any arguments supplied to stack.  You can use the `alpine-stack` command any place you would have used the normal `stack` command.

When the image builds your project the output will be in the '.stack-work' directory just like normal.  Except it will have been built on Alpine Linux and linked to run on Alpine Linux and most likely will not run on your system.

The build script uses the base alpine image, which is only 5MB, copies the application out of the local .stack-work directory into /usr/local/bin in the image.
