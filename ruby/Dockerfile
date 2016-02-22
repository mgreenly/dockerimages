FROM mgreenly/debian:latest

RUN RUBY_MAJOR=2.3 \
    RUBY_VERSION=2.3.0 \
    RUBY_SHA256=ba5ba60e5f1aa21b4ef8e9bf35b9ddb57286cb546aac4b5a28c71f459467e507 \
    RUBYGEMS_VERSION=2.5.1 \
    BUNDLER_VERSION=1.11.2 \
    && cd /tmp \
    && curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
    && echo "$RUBY_SHA256 ruby.tar.gz" | sha256sum -c - \
    && tar -xvf ruby.tar.gz \
    && cd /tmp/ruby-$RUBY_VERSION \
    && autoconf \
    && ./configure --disable-install-doc \
    && make -j"$(nproc)" \
    && make install \
    && echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc" \
    && echo 'install: --no-document\nupdate: --no-document' >> "/etc/skel/.gemrc" \
    && gem update --system $RUBY_GEMS_VERSION \
    && gem install --no-document bundler:$BUNDLER_VERSION \
    && rm -rf /tmp/ruby*
