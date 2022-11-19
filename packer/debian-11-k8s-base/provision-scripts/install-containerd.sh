#!/bin/sh

set -e

CONTAINERD_VERSION=1.6.9
RUNC_VERSION=1.1.4
CNI_VERSION=1.1.1
OS=linux
ARCH=amd64

cd /tmp

# 1. Install containerd
wget -qc https://github.com/containerd/containerd/releases/download/v$CONTAINERD_VERSION/containerd-$CONTAINERD_VERSION-$OS-$ARCH.tar.gz
wget -qc https://github.com/containerd/containerd/releases/download/v$CONTAINERD_VERSION/containerd-$CONTAINERD_VERSION-$OS-$ARCH.tar.gz.sha256sum
sha256sum -c /tmp/containerd-$CONTAINERD_VERSION-$OS-$ARCH.tar.gz.sha256sum

tar Cxzvf /usr/local containerd-$CONTAINERD_VERSION-$OS-$ARCH.tar.gz

# Install systemd service
mkdir -p /usr/local/lib/systemd/system
touch /usr/local/lib/systemd/system/containerd.service
wget -qO /usr/local/lib/systemd/system/containerd.service https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
systemctl daemon-reload
systemctl enable --now containerd

# 2. Install runc
wget -qc https://github.com/opencontainers/runc/releases/download/v$RUNC_VERSION/runc.$ARCH
# TODO: check GPG checksum
install -m 755 runc.$ARCH /usr/local/sbin/runc

# 3. Install CNI plugins
wget -qc https://github.com/containernetworking/plugins/releases/download/v$CNI_VERSION/cni-plugins-$OS-$ARCH-v$CNI_VERSION.tgz
wget -qc https://github.com/containernetworking/plugins/releases/download/v$CNI_VERSION/cni-plugins-$OS-$ARCH-v$CNI_VERSION.tgz.sha256
sha256sum -c cni-plugins-$OS-$ARCH-v$CNI_VERSION.tgz.sha256

mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-$OS-$ARCH-v$CNI_VERSION.tgz