#! /usr/bin/env bash

set -euxo pipefail

cp configs/ip-forward.conf /etc/sysctl.d/

cp configs/resolv.conf /etc/

cat configs/hostapd.conf | envsubst > /etc/hostapd/hostapd.conf

cp configs/dnsmasq.conf /etc/

cp configs/.bash_profile /root/
