FROM alpine:latest

ADD .stack-work/install/x86_64-linux/lts-5.1/7.10.3/bin /main

RUN apk update \
    && apk add gmp

CMD /main/hello-world-app
