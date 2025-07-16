#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# linked to /usr/local required for npm and pip installs
mkdir /var/usrlocal
mkdir /var/roothome

# Random system dependencies
dnf5 install -y \
  webkit2gtk4.0-devel

# Developer tools
dnf5 install -y \
  gcc \
  git

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
  clang \
  clang-tools-extra

# Text editors
dnf5 install -y \
  emacs \
  neovim

# CLI/TUI tools
dnf5 copr enable atim/lazygit -y
dnf5 install -y \
  cmake \
  direnv \
  htop \
  lazygit \
  just \
  make \
  tmux \
  minicom
dnf5 copr disable atim/lazygit -y

# Aider must be installed using python3.12 as of 2025-06-26
dnf5 install -y python3.12
pip --python /usr/bin/python3.12 \
  install --no-cache-dir \
  aider-chat \
  playwright

dnf5 install -y \
  chromium

# Random utils
dnf5 install -y \
  coreos-installer \
  butane \
  stow

cd /tmp
curl --proto '=https' --tlsv1.2 -fsSL \
  https://get.opentofu.org/install-opentofu.sh \
  -o install-opentofu.sh
chmod +x install-opentofu.sh
./install-opentofu.sh --install-method rpm
cd /

# Optional Emacs dependencies
dnf5 install -y \
  aspell \
  aspell-en \
  fd-find \
  ripgrep \
  shellcheck \
  sqlite

pip install --no-cache-dir \
  black \
  flake8 \
  isort \
  python-lsp-server

npm install -g \
  dockerfile-language-server-nodejs \
  eslint \
  typescript-language-server \
  typescript \
  prettier

curl -o /etc/yum.repos.d/hashicorp.repo \
  https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
dnf5 install -y terraform-ls

dnf5 install -y \
  virt-manager \
  virt-viewer


#### Example for enabling a System Unit File

systemctl enable podman.socket
