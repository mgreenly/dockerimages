FROM alpine:latest

ENV SYSTEM_PACKAGES \
  postgresql-client \
  libxml2 \
  libffi \
  tzdata \
  libressl

ENV RUBY_PACKAGES  \
  ruby \
  ruby-irb \
  ruby-bundler \
  ruby-io-console \
  ruby-json \
  ruby-bigdecimal

RUN apk update \
    && apk add $SYSTEM_PACKAGES \
    && apk add $RUBY_PACKAGES \
    && rm -rf /var/cache/apk/*

CMD /bin/sh
