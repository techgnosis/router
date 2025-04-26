#! /usr/bin/env bash

set -euxo pipefail

# intel 1GB

ip address add 192.168.0.222/24 broadcast 192.168.0.255 dev enp0s31f6

ip link set dev enp0s31f6 up



# realtek 2.5GB

ip address add 10.0.0.1/24 broadcast 10.0.0.255 dev enp4s0

ip link set dev enp4s0 up



# bridge
# the bridge device gets made when I start hostapd

ip link set dev br0 up

ip link set enp4s0 master br0

bridge link



# routes

ip route add 0.0.0.0/0 via 192.168.0.1

# iptables

iptables flush

iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s31f6 -j MASQUERADE

