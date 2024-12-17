FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    git \
    zsh \
    unzip \
    wget \
    build-essential \
    software-properties-common \
    clangd \
    clang \
    g++ \
    && apt-get clean

WORKDIR /root

RUN curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz \
    && tar xzf nvim-linux64.tar.gz \
    && mv nvim-linux64 /usr/local/nvim \
    && ln -s /usr/local/nvim/bin/nvim /usr/bin/nvim

RUN git clone --depth 1 https://github.com/syuya2036/dotfiles.git /root/dotfiles \
    && cd /root/dotfiles \
    && git pull

RUN chsh -s /usr/bin/zsh root
RUN mkdir -p /root/.local/bin
RUN curl -L git.io/antigen > /root/.local/bin/antigen.zsh
RUN curl https://mise.run | sh
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN chmod +x /root/dotfiles/init.sh && /root/dotfiles/init.sh
CMD [ "zsh" ]
