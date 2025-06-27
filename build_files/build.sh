#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Developer tools
dnf5 install -y \
  gcc \
  git \

# Programming languages
dnf5 install -y \
  python3 \
  python3-pip \
  python3-virtualenv \
  nodejs \
  npm \
  rust \
  cargo \
  golang \
  ruby-devel \
  rubygems \

# Text editors
dnf5 install -y \
  emacs \
  neovim

# CLI/TUI tools
dnf5 copr enable atim/lazygit -y
dnf5 install -y \
  direnv \
  htop \
  lazygit \
  just \
  make \
  tmux
dnf5 copr disable atim/lazygit -y

# Random utils
dnf5 install -y \
  coreos-installer \
  butane \
  stow

mkdir -p /tmp/
cd /tmp
curl --proto '=https' --tlsv1.2 -fsSL \
  https://get.opentofu.org/install-opentofu.sh \
  -o install-opentofu.sh
chmod +x install-opentofu.sh
./install-opentofu.sh --install-method rpm
cd /
rm -rf /tmp/
mkdir -p /tmp/

# Optional Emacs dependencies
dnf5 instally -y \
  aspell \
  aspell-en \
  fd-find \
  hunspell \
  hunspell-en-US \
  ripgrep

pip install --no-cache-dir \
  black \
  flake8 \
  isort \
  python-lsp-server

npm install -g \
  docker-language-server-nodejs \
  eslint \
  typescript-language-server \
  typescript \
  prettier

curl -o /etc/yum.repos.d/hashicorp.repo \
  https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
dnf5 install -y terraform-ls

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
