FROM debian:10.3

ARG GHC_VER=8.10.1

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

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
    && adduser --disabled-password --gecos "" --uid 1000 $USERNAME \
    && chmod +x /usr/local/bin/entrypoint.sh

ENV PATH="/home/haskell/.cabal/bin:/home/haskell/.ghcup/bin:${PATH}"

USER haskell

RUN mkdir -p $HOME/.ghcup/bin \
    && curl https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > $HOME/.ghcup/bin/ghcup \
    && chmod +x ~/.ghcup/bin/ghcup \
    && ghcup install ${GHC_VER} \
    && ghcup set ${GCH_VER} \
    && ghcup install-cabal

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
