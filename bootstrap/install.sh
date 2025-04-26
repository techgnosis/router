#! /usr/bin/env bash

set -euo pipefail

pacstrap -K /mnt \
base \
linux \
linux-firmware \
micro \
intel-ucode \
efibootmgr \
sudo \
git \
dnsmasq \
hostapd

cp -r /root/router /mnt/root/
