#!/usr/bin/env bash
set -euo pipefail

echo "dnf-update"
sudo dnf update

echo "install build-essential"
sudo dnf install -y build-essential

echo "# install go"
VERSION='1.17'
OS='linux'
ARCH='amd64'

curl -OL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

echo 'PATH="$PATH:/usr/local/go/bin:'$HOME'/go/bin"' >> ~/.bash_aliases

echo "install ebpf tools and dependencies"
sudo dnf install -y make
sudo dnf install -y clang
sudo dnf install -y llvm
sudo dnf install -y pkg-config
sudo dnf install -y libelf-dev
sudo dnf install -y libbpf-dev

echo "# package installations complete!"