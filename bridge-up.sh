#! /usr/bin/env bash

set -euo pipefail

ip link set dev br0 up

ip link set enp4s0 master br0

bridge link