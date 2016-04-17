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
      ncurses-dev \
      ncurses-libs \
      ncurses \
      ncurses5-widec-libs \
      ncurses-terminfo-base \
      ncurses-terminfo \
    && adduser -D -u1000 alpine \
    && mkdir /data

USER alpine

WORKDIR /data
