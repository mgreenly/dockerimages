# alpine-stack

## Introduction

This is a [Docker](https://www.docker.com/) image for a [Stack](http://docs.haskellstack.org/en/stable/README.html) based [Haskell](https://www.haskell.org/) development environment on [Alpine Linux](http://alpinelinux.org/).

It allows you to build very small Docker images for Stack based Haskell applications.

Approximately 8MB for a typical hello world application vs over 1.5GB for Stack's fpco/stack-run image.

This is built on [alpine-linux-ghc-bootstrap](https://github.com/mitchty/alpine-linux-ghc-bootstrap).  I didn't do any of the heavy lifting.  [Mitch Tishmack](https://github.com/mitchty/) deserves all the credit.

I just tried to put his hardwork to good use and make it a little easier for me to use.

## How To Use This

There are two scripts in the bin directory; `alpine-dockerize` and `alpine-stack`.  Add both to a direcotry on your $PATH, for example in $HOME/.local/bin.

Inside the directory of your Haskell project run `alpine-stack init --resolver ghc-8.0.2`.  

Which ever stackage snapshot is used it must be compatible with GHC 8.0.2 because the Stack binary installed in the docker image is limited to using the system installed version of GHC which is currently 8.0.2.

Then run `alpine-dockerize`.

The dockerize script generates a few files `Dockerfile.alpine`, `build.alpine.sh`, and `run.alpine.sh`

The dockerize script is pretty dumb. It's purpose is to provide a baseline that you can evolve for more complex projects.

The `build.alpine.sh` script exists to reduce the build process to a single command. Delete it if you don't want it. I find it saves typing.

The `run.alpine.sh` script exists to make running the binary in a container move convenient.  Delete it if you don't want it.  I find it saves typing.

After running the dockerize script use `./build.alpine.sh` to build the image.

Once the image is built you can use `./run.alpine.sh` to run the image.

## Example

```
stack new hello-world simple --resolver nightly                # create a new project
cd hello-world                                                 # enter project
alpine-dockerize                                               # create docker file and build scripts
./build.alpine.sh                                              # build the image
./run.alpine.sh                                                # run the image
```



## How things work

The `mgreenly/alpine-stack` image provides the development environment.  It has stack, ghc and ghci as well as many common libraries installed on it.  It's big, approximately 1.9GB but it only needs to exist on the developers machine.

The `alpine-stack` script simply runs the `mgreenly/alpine-stack` image, mounts the local project directory in the container and passes any arguments supplied to stack.  You can use the `alpine-stack` command any place you would have used the normal `stack` command.

When the image builds your project the output will be in the '.stack-work' directory just like normal.  Except it will have been built on Alpine Linux and linked to run on Alpine Linux and most likely will not run on your system unless you're running Alpine Linux.

The generated `Dockerfile.alpine` uses the the 4MB Alpine Linux image as the targets base, copies the application out of the local .stack-work directory into the images /usr/local/bin, and sets up a non-privilaged user to run that application in the container.
