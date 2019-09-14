#!/bin/bash

#
# make sure we have the freetds source
#

WORKDIR="$PWD/freetds-0.95.95"

if [ ! -e "$WORKDIR" ]; then
  wget -O freetds-patched.tar.gz ftp://ftp.freetds.org/pub/freetds/stable/freetds-patched.tar.gz
  tar -xvf freetds-patched.tar.gz
fi


#
# run the build script in the docker container
#
docker run --rm -i \
  -v $WORKDIR:/freetds \
  debian:latest \
  /bin/bash  < <(cat build.sh)

#
# copy resulting deb file to top level
#
rm $PWD/*.deb
mv $WORKDIR/*.deb $PWD/
