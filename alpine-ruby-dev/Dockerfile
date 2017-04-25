FROM alpine:latest

ENV GEM_HOME=/home/ruby/.gems
ENV PATH="/home/ruby/.gems/bin:${PATH}"

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
  ruby-io-console \
  ruby-json \
  ruby-bigdecimal

RUN apk update \
    && apk add $BUILD_PACKAGES \
    && apk add $RUBY_PACKAGES \
    && rm -rf /var/cache/apk/* \
    && adduser -D -u1000 ruby \
    && echo "gem: --no-document" > /home/ruby/.gemrc \
    && mkdir /ruby \
    && chown -R ruby.ruby /ruby \
    && su -c "gem install bundler" ruby

USER ruby
WORKDIR /ruby
CMD /bin/sh
