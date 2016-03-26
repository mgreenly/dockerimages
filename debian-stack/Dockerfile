FROM debian:latest

#
# copy all files into image first
#
COPY files/.vimrc     /home/haskell/.vimrc
COPY files/.local/bin /home/haskell/.local/bin

#
# do all system level setup as root
#
RUN USERNAME=haskell \
    DEBIAN_FRONTEND=noninteractive \
    && cd /tmp \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442 \
    && echo 'deb http://download.fpcomplete.com/debian jessie main' | tee /etc/apt/sources.list.d/fpco.list \
    && apt-get -q -y update \
    && apt-get \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        -q -y install \
        sudo \
        vim \
        curl \
        stack \
        libncursesw5-dev \
    && useradd --no-create-home --home-dir=/home/$USERNAME --shell=/bin/bash $USERNAME \
    && adduser $USERNAME sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /home/$USERNAME/project \
    && cp /etc/skel/.bash* /home/$USERNAME/ \
    && cp /etc/skel/.profile* /home/$USERNAME/ \
    && chown $USERNAME.$USERNAME -R /home/$USERNAME


#
# setup the dev environment as haskell 
#
USER haskell
WORKDIR /home/haskell/project
RUN USERNAME=haskell \
    GHC_VERSION=7.10.3 \
    DEBIAN_FRONTEND=noninteractive \
    && stack setup $GHC_VERSION \
    && stack install ghc-mod hoogle hlint hdevtools \
    && echo "export  PATH=\$HOME/.local/bin:\$HOME/.stack/programs/x86_64-linux/ghc-$GHC_VERSION/bin:\$PATH" >> /home/$USERNAME/.bashrc \
    && echo "export  PS1=\"\\w$ \"" >> /home/$USERNAME/.bashrc \
    && mkdir -p /home/$USERNAME/.vim/autoload ~/.vim/bundle \
    && curl -LSso /home/$USERNAME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim \
    && cd /home/$USERNAME/.vim/bundle \
    && git clone git://github.com/tpope/vim-sensible.git \
    && git clone https://github.com/bitc/vim-hdevtools.git \
    && git clone https://github.com/scrooloose/syntastic.git

