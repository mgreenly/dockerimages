FROM mgreenly/debian:latest

RUN RUBY_MAJOR=2.3 \
    RUBY_VERSION=2.3.1 \
    RUBY_SHA256=b87c738cb2032bf4920fef8e3864dc5cf8eae9d89d8d523ce0236945c5797dcd \
    RUBYGEMS_VERSION=2.6.7 \
    BUNDLER_VERSION=1.13.2 \
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
    && gem install --no-document bundler \
    && rm -rf /tmp/ruby*
