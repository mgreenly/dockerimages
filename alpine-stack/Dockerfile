FROM mitchty/alpine-ghc:latest

RUN apk update \
    && apk add make gcc musl-dev \
    && adduser -D alpine-stack \
    && mkdir /data

USER alpine-stack

WORKDIR /data
