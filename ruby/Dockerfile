FROM mgreenly/debian

RUN RUBY_MAJOR=2.1 \
    RUBY_VERSION=2.1.7 \
    RUBY_SHA256=f59c1596ac39cc7e60126e7d3698c19f482f04060674fdfe0124e1752ba6dd81 \
    RUBYGEMS_VERSION=2.5.0 \
    BUNDLER_VERSION=1.10.6 \
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
