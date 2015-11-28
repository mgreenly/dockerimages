FROM debian:jessie


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q -y update &&                  \
    apt-get                                  \
      -o Dpkg::Options::="--force-confdef"   \
      -o Dpkg::Options::="--force-confold"   \
      -q -y install                          \
      htop                                   \
      automake                               \
      bison                                  \
      build-essential                        \
      ca-certificates                        \
      curl                                   \
      git                                    \
      imagemagick                            \
      libbz2-dev                             \
      libc6-dev                              \
      libcurl4-openssl-dev                   \
      libevent-dev                           \
      libffi-dev                             \
      libgdbm-dev                            \
      libglib2.0-dev                         \
      libjpeg-dev                            \
      libmagickcore-dev                      \
      libmagickwand-dev                      \
      libmysqlclient-dev                     \
      libncurses-dev                         \
      libpq-dev                              \
      libreadline6                           \
      libreadline6-dev                       \
      libreadline-dev                        \
      libsqlite3-dev                         \
      libssl-dev                             \
      libssl-dev                             \
      libtool                                \
      libxml2-dev                            \
      libxml2-dev                            \
      libxslt-dev                            \
      libxslt-dev                            \
      libyaml-dev                            \
      libyaml-dev                            \
      ncurses-dev                            \
      pkg-config                             \
      zlib1g-dev                             \
      freetds-dev                            \
      freetds-bin                            \
      unixodbc-bin                           \
      tdsodbc                                \
      && rm -rf /var/lib/apt/lists/*
