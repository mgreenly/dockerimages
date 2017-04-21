FROM alpine:latest

ENV BUILD_PACKAGES \
  bash \
  build-base \
  libxml2-dev \
  postgresql-dev \
  libffi-dev \
  ruby-dev \
  tzdata \
  libressl-dev \
  nodejs

ENV RUBY_PACKAGES \
  ruby \
  ruby-irb \
  ruby-bundler \
  ruby-io-console \
  ruby-json \
  ruby-bigdecimal

RUN apk update \
    && apk add $BUILD_PACKAGES \
    && apk add $RUBY_PACKAGES \
    && rm -rf /var/cache/apk/*

CMD /bin/sh
