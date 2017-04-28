FROM alpine:latest

ENV GEM_HOME=/home/ruby/.gem

ENV BUILD_PACKAGES \
  bash \
  tzdata \
  build-base \
  nodejs \
  ruby-dev \
  postgresql-dev \
  libffi-dev \
  libressl-dev \
  libxml2-dev

ENV RUBY_PACKAGES \
  ruby \
  ruby-irb \
  ruby-io-console \
  ruby-json \
  ruby-bigdecimal

ENV PATH="/home/ruby/.alpine-gem/bin:${PATH}"

RUN apk update \
    && apk add $BUILD_PACKAGES \
    && apk add $RUBY_PACKAGES \
    && rm -rf /var/cache/apk/* \
    && adduser -D -u1000 ruby \
    && echo "gem: --no-document" > /home/ruby/.gemrc \
    && mkdir /workdir \
    && chown -R ruby.ruby /workdir

USER ruby
WORKDIR /workdir
CMD /bin/sh


#    && su -c "gem install bundler" ruby
