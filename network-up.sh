#! /usr/bin/bash

set -euo pipefail

ip address add 192.168.1.200/24 broadcast 192.168.1.255 dev enp0s31f6

ip link set dev enp0s31f6 up

ip route add 0.0.0.0/0 via 192.168.1.1

ping yahoo.com
