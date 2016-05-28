# alpine-stack

## Introduction

This is a [Docker](https://www.docker.com/) image for a [Stack](http://docs.haskellstack.org/en/stable/README.html) based [Haskell](https://www.haskell.org/) development environment on [Alpine Linux](http://alpinelinux.org/).

It allows you to build very small Docker images for Stack based Haskell applications.

Approximately 7MB for a typical hello world application vs 128MB for the same application on Debian stable.

This is built on [alpine-linux-ghc-bootstrap](https://github.com/mitchty/alpine-linux-ghc-bootstrap).  I didn't do any of the heavy lifting.  [Mitch Tishmack](https://github.com/mitchty/) deserves all the credit.

I just tried to put his hardwork to good use and make it a little easier for me to use.

## How To Use This

There are two scripts in the bin directory; `alpine-dockerize` and `alpine-stack`.  Add both to a direcotry on your $PATH, for example in $HOME/.local/bin.

Inside the directory of your Stack based Haskell project run `alpine-dockerize`.

The dockerize script generates a few files.  `Dockerfile.alpine`, `.dockerignore`, `build.alpine.sh`, and `run.alpine.sh`

The dockerize script is pretty dumb.  It assumes there's only a single executable defined in the cabal files and generates the necessary commands to copy it into the image.  It's purpose is to provide a baseline that you can evolve for your project.

The `build.alpine.sh` script is to reduce my build process to a single command. Delete it if you don't want it. I find it saves typing.

The `run.alpine.sh` script is to reduce the size of the command necessary to run the container.  Delete it if you don't want it.  I find it saves typing.

The docker and stack related directories not needed by the build context are added to the `.dockerignore` file.

After running the dockerize script use `./build.alpine.sh` to build the image.

Once the image is built you can use `./run.alpine.sh` to run the image.

## Example

Here's an example without using my build and run scripts.

```
stack new hello-world                                          # create new stack project
cd hello-world                                                 # enter project
alpine-dockerize                                               # create docker/build.sh scripts
alpine-stack build                                             # build manually
docker build -f Dockerfile.alpine -t hello-world .             # build the image
docker run hello-world                                         # run the image
```


## How things work

The `mgreenly/alpine-stack` image provides the development environment.  It has stack, ghc and ghci as well as many common libraries installed on it.  It's big, approximately 1.2GB but it only needs to exist on the developers machine.

The `alpine-stack` script simply runs the `mgreenly/alpine-stack` image, mounts the local project directory in the container and passes any arguments supplied to stack.  You can use the `alpine-stack` command any place you would have used the normal `stack` command.

When the image builds your project the output will be in the '.stack-work' directory just like normal.  Except it will have been built on Alpine Linux and linked to run on Alpine Linux and most likely will not run on your system unless you're running Alpine Linux.

The generated `Dockerfile.alpine` uses the the 5MB Alpine Linux image as the targets base, copies the application out of the local .stack-work directory into the images /usr/local/bin, and sets up a non-privilaged user to run that application in the container.
