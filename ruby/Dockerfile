FROM mgreenly/debian

ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.7
ENV RUBY_DOWNLOAD_SHA256 f59c1596ac39cc7e60126e7d3698c19f482f04060674fdfe0124e1752ba6dd81
ENV RUBYGEMS_VERSION 2.5.0
ENV BUNDLER_VERSION 1.10.6

WORKDIR /tmp

RUN curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz"
RUN  echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c -
RUN  tar -xvf ruby.tar.gz
RUN cd /tmp/ruby-"$RUBY_VERSION" \
 && autoconf \
 && ./configure --disable-install-doc\
 && make -j"$(nproc)" \
 && make install

RUN echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc" \
 && echo 'install: --no-document\nupdate: --no-document' >> "/etc/skel/.gemrc" \
 && gem update --system $RUBYGEMS_VERSION \
 && gem install --no-document bundler:"$BUNDLER_VERSION"

RUN rm ruby.tar.gz
