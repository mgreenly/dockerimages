# debian-stack

## Introduction

This is a [Docker](https://www.docker.com/) image for a [Stack](http://docs.haskellstack.org/en/stable/README.html) based [Haskell](https://www.haskell.org/) development environment on [Debian Linux](https://www.debian.org/).

It allows you to build relatively small Docker images for Stack based Haskell applications.

Approximately 126MB for a typical hello world application.

## How To Use This

There are two scripts in the bin directory.  Add both to a direcotry on your $PATH, for example $HOME/.local/bin.

Inside the directory of your stack project run `debian-dockerize`.

The dockerize script generates a few files.  Dockerfile.debian, .dockerignore, build.debian.sh, and run.debian.sh

The dockerize script generates a 'Dockerfile'.  The  dockerize script is pretty dumb.  It assumes there's only a single executable defined in the cabal files and generates the necessary commands to copy it into the image.  It's purpose is to provide a baseline that you can evolve for your proejct.

The dockerize script also generates a 'build.debian.sh' script.  This scripts purpose is to reduce the build process to a single command. Delete it if you don't want it. I find it saves typing.

The dockerize script also generates a 'run.debian.sh' script.  This scripts purpose is to reduce the typing necessary to run the produced container.  Delete it if you don't want it.

The dockerize script also generates a .dockerignore file if necessary and adds the necesary entries.

After running the dockerize script just run `.\build.debian.sh` to build the image.

Then use `./run.debian.sh` to run the image

# WARNING!!!

The Dockerfile that's created doesn't install any shared libraries that you may need.  There's two ways to deal with this.  Either modify the Dockerfile to add them or build a static binary.

I prefer to build a static binary and use something like this in the executable stanza of my cabal file

       ghc-options:   -O2
                      -threaded
                      -with-rtsopts=-N
                      -static
                      -optc-static
                      -optl-static
                      -optl-pthread



## Example.

Doing this for a hello-world application may look like this.

```
stack new hello-world                               # create new stack project
cd hello-world                                      # enter project
debian-dockerize                                    # create docker/build.sh scripts
debian-stack build                                  # use stack to build the application
docker build -f Dockerfile.debian -t hello-world .  # create docker image manually
docker run hello-world                              # run the image
```


## Details

The `mgreenly/debian-stack` image is only the development environment.  It has stack, ghc and ghci as well as many common libraries installed on it.  It's big, approximately 400MB but it only needs to exist on the development machine.

The `debian-stack` script simply runs that docker image, mounts the local project directory for it and passes any arguments supplied to stack.  You can use the `debian-stack` command any place you would have used the normal `stack` command.

When the image builds your project the output will be in the '.stack-work' directory just like normal.  Except it will have been built on Debian Linux and linked to run on Debian Linux and most likely will not run on your system.

The build script uses the base debian image, which is only 125MB, copies the application out of the local .stack-work directory into /usr/local/bin in the image.
