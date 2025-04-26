#! /usr/bin/env bash

set -euo pipefail

efibootmgr \
--create \
--disk /dev/sda \
--part 1 \
--label "Arch" \
--loader vmlinuz-linux \
--unicode ' root=/dev/sda2 initrd=initramfs-linux.img initrd=intel-ucode.img'