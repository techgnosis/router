#! /usr/bin/bash

set -euo pipefail

# nic1 is the integrated 1GiB NIC

ip address add 192.168.0.222/24 broadcast 192.168.0.255 dev enp0s31f6

ip link set dev enp0s31f6 up
