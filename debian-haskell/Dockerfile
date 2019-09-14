FROM debian:buster

#
# This is just a prototype to flesh out the idea.  If this all works
# this will be optimized for size later
#
RUN USERNAME=haskell \
    DEBIAN_FRONTEND=noninteractive \
    && cd /tmp \
    && apt-get -q -y update \
    && apt-get \
      -o Dpkg::Options::="--force-confdef" \
      -o Dpkg::Options::="--force-confold" \
      -q -y install \
      build-essential \
      curl \
      libgmp-dev \
      libffi-dev \
      libncurses-dev \
      libtinfo5 \
    && adduser --disabled-password --gecos "" --uid 1000 $USERNAME
    # && chown $USERNAME.$USERNAME /workdir

USER haskell
RUN mkdir -p $HOME/.ghcup/bin
RUN curl https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > $HOME/.ghcup/bin/ghcup
RUN chmod +x ~/.ghcup/bin/ghcup

ENV PATH="/home/haskell/.cabal/bin:/home/haskell/.ghcup/bin:${PATH}"

RUN ghcup install 8.8
RUN ghcup set 8.8
RUN ghcup install-cabal


# RUN curl https://raw.githubusercontent.com/haskell/ghcup/master/bootstrap-haskell -sSf | env BOOTSTRAP_HASKELL_NONINTERACTIVE=true sh -s 8.8
# RUN curl https://gitlab.haskell.org/haskell/ghcup/raw/master/bootstrap-haskell -sSf | env BOOTSTRAP_HASKELL_NONINTERACTIVE=true sh
# RUN rm -rf /home/haskell/.cabal

# WORKDIR /workdir
