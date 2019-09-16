FROM ruby:2.6.4-stretch

#
# This is just a prototype to flesh out the idea.  If this all works
# this will be optimized for size later
#
RUN USERNAME=ruby \
    DEBIAN_FRONTEND=noninteractive \
    && cd /tmp \
    && apt-get -q -y update \
    && apt-get \
      -o Dpkg::Options::="--force-confdef" \
      -o Dpkg::Options::="--force-confold" \
      -q -y install \
    && adduser --disabled-password --gecos "" --uid 1000 $USERNAME

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

USER ruby

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
