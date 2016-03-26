#!/usr/bin/env bash


#
# 
#

if [ $# -ne 1 ]; then
  echo "aborting, incorrect number of arguments supplied."
  echo "usage: install TARGET_DIR"
  exit 1
fi
TARGET_DIR=$1


if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $TARGET_DIR
fi


if [[ "$PATH" != ?(*:)"$TARGET_DIR"?(:*) ]]; then
  echo ""
  echo "WARNING!!!"
  echo ""
  echo "$TARGET_DIR not included in \$PATH"
  echo ""
fi

cat << EOF > $TARGET_DIR/debian-stack
#!/bin/sh

docker run --rm -i -t \\
  -v \$PWD:/data \\
  mgreenly/debian-stack:latest \\
  stack \$@
EOF

cat << EOF > $TARGET_DIR/debian-stack-shell
#!/bin/sh

docker run --rm -i -t \
  -v \$PWD:/home/haskell/project \
  mgreenly/debian-stack:latest  \
  /bin/bash
EOF

cat << EOF > $TARGET_DIR/debian-stack-vim
#!/bin/sh

docker run --rm -i -t \
  -v \$PWD:/home/haskell/project \
  mgreenly/debian-stack:latest  \
  vim \$@
EOF

chmod +x $TARGET_DIR/debian-stack*


docker pull mgreenly/debian-stack
