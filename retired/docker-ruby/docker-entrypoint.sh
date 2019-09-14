#!/bin/bash
set -e


#echo "using UID: ${id}"
#
##adduser --disabled-password --gecos "" --uid ${id} stretch
#
##echo "setting ownership of: $RBENV_ROOT"
##chown -R ${id}:${id} $RBENV_ROOT
###chown -R ${id}:${id} /workdir 
##
##export PATH=$RBENV_ROOT/bin:\$PATH
##
###eval "$(rbenv init -)"
#
#exec "$@"


# add 
USER_ID=${LOCAL_USER_ID:-1000}
echo "using UID: $USER_ID"

adduser --disabled-password --gecos "" --uid $USER_ID stretch

echo "setting ownership of: $RBENV_ROOT"
chown -R stretch.stretch $RBENV_ROOT
chown -R stretch.stretch /workdir 
cd $RBENV_ROOT
src/configure
make -C src 

echo "export PATH=$RBENV_ROOT/bin:\$PATH" | tee -a /home/stretch/.bashrc
echo 'eval "$(rbenv init -)"' | tee -a /home/stretch/.bashrc

exec su -s /bin/bash stretch

#exec "$@"

#exec /bin/su -c '/bin/bash --login' stretch

#exec "$@"
