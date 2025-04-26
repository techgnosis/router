#! /usr/bin/env bash

set -euo pipefail

pacstrap -K /mnt \
base \
linux \
linux-firmware \
micro \
intel-ucode \
efibootmgr \
git \
less \
which \
net-tools \
dnsmasq \
hostapd
