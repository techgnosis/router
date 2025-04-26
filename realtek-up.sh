#! /usr/bin/bash

set -euo pipefail

# nic2 is the PCI 2.5GiB

ip address add 10.0.0.1/24 broadcast 10.0.0.255 dev enp4s0

ip link set dev enp4s0 up
