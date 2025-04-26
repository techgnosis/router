#! /usr/bin/bash

set -euo pipefail

ip address add 10.0.0.1/24 broadcast 10.0.0.255 dev enp4s0

ip link set dev enp4s0 up
