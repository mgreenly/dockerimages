# debian-stack

## Introduction

This is a [Docker](https://www.docker.com/) image for [Stack](http://docs.haskellstack.org/en/stable/README.html) based [Haskell](https://www.haskell.org/) development on [Debian Linux](https://www.debian.org/).

It allows you to build relatively small Docker images for Haskell applications.

Approximately 126MB for a typical hello world application vs over 1.5GB for Stack's fpco/stack-run image.

## How To Use This

There are two scripts in the bin directory.  Add both to a direcotry on your $PATH, for example in $HOME/.local/bin.

Inside the directory of your stack project run `debian-dockerize`.

The dockerize script generates a few files.  Dockerfile.debian, build.debian.sh, and run.debian.sh

The dockerize script generates a 'Dockerfile'. It's purpose is to provide a baseline that you can evolve for your proejct.

The dockerize script also generates a 'build.debian.sh' script.  This scripts purpose is to reduce the build process to a single command. Delete it if you don't want it. I find it saves typing.

The dockerize script also generates a 'run.debian.sh' script.  This scripts purpose is to reduce the typing necessary to run the produced container.  Delete it if you don't want it.

After running the dockerize script just run `.\build.debian.sh` to build the image.

Then use `./run.debian.sh` to run the image

## Example.

Doing this for a hello-world application may look like this.

```
stack new hello-world simple                        # create new stack project
cd hello-world                                      # enter project
debian-dockerize                                    # create docker/build.sh scripts
./build-debian.sh                                   # build the image 
./run.debian.sh                                     # run the image
```


## Details

The `mgreenly/debian-stack` image is only the development environment.  It has stack, ghc and ghci as well as many common libraries installed on it.  It's big, approximately 400MB but it only needs to exist on the development machine.

The `debian-stack` script simply runs that docker image, mounts the local project directory in the container and passes any arguments supplied to stack.  You can use the `debian-stack` command any place you would have used the normal `stack` command.

When the image builds your project the output will be in the '.stack-work' directory just like normal.  Except it will have been built on Debian Linux and linked to run on Debian Linux and most likely will not run on your system.

The build script uses the base debian image, which is only 125MB, copies the application out of the local .stack-work directory into /usr/local/bin in the image.  The generated Dockerfile sets the application up to be run as a non-privelaged user inside the image.
