#!/usr/bin/env bash

set -euxo pipefail

# BRIEF REFRESHER EXAMPLE

# PREROUTING -> INPUT or FORWARD 

# CenturyLink Router
# Public - 50.50.50.50
# Private - 192.168.0.1

# Laptop
# Private - 192.168.0.79

# Packet comes in
# DEST 50.50.50.50
# SNAT occurs in PREROUTING
# Did the destination IP remain 50.50.50.50? INPUT
# Did the destination IP become 192.168.0.1? INPUT
# Did the destination IP become 192.168.0.79? FORWARD

iptables \
--table filter \
--flush INPUT

iptables \
--table filter \
--policy INPUT DROP

iptables \
--table filter \
--append INPUT \
--protocol tcp \
--syn \
--match limit \
--limit 1/s \
--limit-burst 3 \
--jump ACCEPT


iptables \
--table filter \
--append INPUT \
--in-interface lo \
--jump ACCEPT

iptables \
--table filter \
--append INPUT \
--in-interface br0 \
--jump ACCEPT

iptables \
--table filter \
--append INPUT \
--in-interface enp0s31f6 \
--match state \
--state ESTABLISHED,RELATED \
--jump ACCEPT

iptables \
--table filter \
--append INPUT \
--jump LOG \
--match limit \
--limit-burst 1 \
--limit '30/minute' \
--log-prefix "INPUT_DROP:" \
--log-level info




iptables \
--table filter \
--flush FORWARD

iptables \
--table filter \
--policy FORWARD DROP

iptables \
--table filter \
--append FORWARD \
--in-interface br0 \
--out-interface enp0s31f6 \
--jump ACCEPT

iptables \
--table filter \
--append FORWARD \
--in-interface enp0s31f6 \
--out-interface br0 \
--match state \
--state ESTABLISHED,RELATED \
--jump ACCEPT

iptables \
--table filter \
--append FORWARD \
--jump LOG \
--match limit \
--limit-burst 1 \
--limit '30/minute' \
--log-prefix "FORWARD_DROP:" \
--log-level info




iptables \
--table nat \
--flush POSTROUTING

iptables \
--table nat \
--append POSTROUTING \
--source 10.0.0.0/24 \
--out-interface enp0s31f6 \
--jump MASQUERADE
