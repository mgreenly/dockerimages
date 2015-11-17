FROM mgreenly/jessie

ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.7
ENV RUBY_DOWNLOAD_SHA256 f59c1596ac39cc7e60126e7d3698c19f482f04060674fdfe0124e1752ba6dd81
ENV RUBYGEMS_VERSION 2.5.0
ENV BUNDLER_VERSION 1.10.6

RUN apt-get update \
    && apt-get install -y bison libgdbm-dev ruby \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/ruby \
    && curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
    && echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
    && tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
    && rm ruby.tar.gz \
    && cd /usr/src/ruby \
    && autoconf \
    && ./configure --disable-install-doc \
    && make -j"$(nproc)" \
    && make install \
    && apt-get purge -y --auto-remove bison libgdbm-dev ruby \
    && gem update --system $RUBYGEMS_VERSION \
    && rm -r /usr/src/ruby

RUN echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc"
RUN echo 'install: --no-document\nupdate: --no-document' >> "/etc/skel/.gemrc"
RUN gem install bundler --version "$BUNDLER_VERSION"

CMD [ "irb" ]
