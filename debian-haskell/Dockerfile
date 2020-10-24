ARG FROM_IMAGE="debian"
ARG FROM_TAG="10-slim"
ARG GHC_VER=8.8.4
ARG CABAL_VER=3.2.0.0

FROM ${FROM_IMAGE}:${FROM_TAG}

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
      libffi-dev  \
      libffi6 \
      libgmp-dev \
      libgmp10 \
      libncurses-dev \
      libncurses5 \
      libtinfo5 \
    && adduser --disabled-password --gecos "" --uid 1000 $USERNAME \
    && chmod +x /usr/local/bin/entrypoint.sh

ENV PATH="/home/haskell/.cabal/bin:/home/haskell/.ghcup/bin:${PATH}"

USER haskell

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org |\
    BOOTSTRAP_HASKELL_NONINTERACTIVE=true \
    BOOTSTRAP_HASKELL_GHC_VERSION=${GHC_VER} \
    BOOTSTRAP_HASKELL_CABAL_VERSION=${CABAL_VER} \
    sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
