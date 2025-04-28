#! /usr/bin/env bash

set -euxo pipefail

# intel 1GB

ip address add 192.168.0.222/24 broadcast 192.168.0.255 dev enp0s31f6

ip link set dev enp0s31f6 up



# realtek 2.5GB

# not adding an IP because the IP goes on the bridge device
# after this device is attached to the bridge

ip link set dev enp4s0 up


# bridge

ip link add name br0 type bridge

ip link set dev br0 up

ip link set enp4s0 master br0
# there is no "link set wlp3s0 master br0"
# the wifi device is added to the bridge by hostapd

ip address add 10.0.0.1/24 broadcast 10.0.0.255 dev br0

bridge link


# wifi

systemctl start hostapd

# dns and dhcp

systemctl start dnsmasq



# routes

ip route add 0.0.0.0/0 via 192.168.0.1
