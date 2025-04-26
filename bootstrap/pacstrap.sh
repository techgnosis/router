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
# less is for `git log` and `git diff`
# direnv is for the SSID and WPA3_PASSPHRASE variables in hostapd.conf
