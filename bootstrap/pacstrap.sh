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
direnv \
net-tools \
dnsmasq \
hostapd

# net-tools is for netstat
# less is got `git log` and `git diff`
