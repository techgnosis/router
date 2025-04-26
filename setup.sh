#! /usr/bin/env bash

set -euo pipefail


cp 99-ip-forward.conf /etc/systemctl.d/

cp resolv.conf /etc/

cp hostapd.conf /etc/hostapd/

./integrated-up.sh

./pci-up.hostapd

./routes-up.sh