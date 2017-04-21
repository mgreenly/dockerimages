FROM alpine:latest

ENV SYSTEM_PACKAGES postgresql-client libxml2 libffi nodejs tzdata libressl
ENV RUBY_PACKAGES ruby ruby-irb ruby-bundler ruby-io-console  ruby-json ruby-bigdecimal

RUN apk update \
    && apk add $SYSTEM_PACKAGES \
    && apk add $RUBY_PACKAGES 

CMD /bin/sh
