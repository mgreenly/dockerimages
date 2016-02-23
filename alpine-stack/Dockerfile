FROM mitchty/alpine-ghc:latest

RUN apk update \
    && apk add \
      make \
      gcc \
      musl-dev \
      curl-dev \
      freetds-dev \
      imagemagick-dev \
      libevent-dev \
      libffi-dev \
      libxml2-dev \
      ncurses-dev \
      openssl-dev \
      postgresql-dev \
      readline-dev \
      sqlite-dev \
      unixodbc-dev \
      yaml-dev \
      zlib-dev \
    && adduser -D alpine-stack \
    && mkdir /data

USER alpine-stack

WORKDIR /data
