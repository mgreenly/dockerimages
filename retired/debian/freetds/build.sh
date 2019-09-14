#!/bin/bash

PACKAGENAME=freetds
MAINTAINER=mgreenly
PKGVERSION=95.95
PKGRELEASE=mg.1


apt-get -q -y update
apt-get                                \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -q -y install                        \
  gawk                                 \
  build-essential                      \
  fakeroot                             \
  checkinstall                         \
  libsasl2-dev                         \
  unixodbc-dev                         \

cd /freetds
./configure
make clean
make
make install

mv freetds.spec freetds.spec.bak

checkinstall \
  --type=debian \
  --install=no \
  --nodoc \
  --pkgname=$PACAGENAME \
  --maintainer=$MAINTAINER \
  --pkgversion=$PKGVERSION \
  --pkgrelease=$PKGRELEASE \
  --default

echo "SUCCESS"
