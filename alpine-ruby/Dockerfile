FROM alpine:latest

RUN apk update \
    && apk add \
      ruby \
    && adduser -D -u1000 alpine \
    && mkdir /project \
    && chown alpine.alpine /project

USER alpine

WORKDIR /project

CMD /bin/sh
