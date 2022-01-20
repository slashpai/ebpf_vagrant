#!/usr/bin/env bash

set -euo pipefail

echo "install build-essential"
sudo dnf -y install @development-tools

echo "# install go"
VERSION='1.17'
OS='linux'
ARCH='amd64'

curl -OL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

echo 'PATH="$PATH:/usr/local/go/bin:'$HOME'/go/bin"' >> ~/.bash_aliases

echo "install ebpf tools and dependencies"
sudo dnf -y install clang
sudo dnf -y install llvm
sudo dnf -y install libbpf

# because its a useful tool for json processing
# adding it for future use
echo "install jq"
sudo dnf -y install jq

echo "install docker packages"
FEDORA_VERSION='35'
DOCKER_PACKAGES=(docker-ce-cli-20.10.12-3.fc35.x86_64.rpm docker-scan-plugin-0.12.0-3.fc35.x86_64.rpm docker-ce-rootless-extras-20.10.12-3.fc35.x86_64.rpm docker-ce-20.10.12-3.fc35.x86_64.rpm containerd.io-1.4.12-3.1.fc35.x86_64.rpm)

for i in ${DOCKER_PACKAGES[@]}; do
  curl -OL "https://download.docker.com/linux/fedora/${FEDORA_VERSION}/x86_64/stable/Packages/${i}"
done

# need to install packages together since there is dependencies between them
sudo dnf -y install ${DOCKER_PACKAGES[@]}

# to let current user run docker commands as non-sudo
sudo usermod -aG docker $USER
newgrp docker

sudo systemctl start docker
sudo systemctl status docker

echo "# package installations complete!"
