FROM mitchty/alpine-ghc:latest

RUN apk update \
    && apk add \
      make \
      gcc \
      musl-dev \
      postgresql-dev \
    && adduser -D alpine-stack \
    && mkdir /data

USER alpine-stack

WORKDIR /data
