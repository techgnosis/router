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

# lets me run `curl localhost` in a router shell
iptables \
--table filter \
--append INPUT \
--in-interface lo \
--jump ACCEPT

# lets my laptop reach dnsmasq on the router
iptables \
--table filter \
--append INPUT \
--in-interface br0 \
--jump ACCEPT

# lets router processes get return traffic
iptables \
--table filter \
--append INPUT \
--in-interface enp0s31f6 \
--match state \
--state ESTABLISHED,RELATED \
--jump ACCEPT

# any packets left after all the ACCEPT jumps is dropped after this log statement
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

# lets my laptop send internet bound traffic
iptables \
--table filter \
--append FORWARD \
--in-interface br0 \
--out-interface enp0s31f6 \
--jump ACCEPT

# lets my laptop get return traffic
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

# lets hosts with private addresses reach internet hosts via SNAT
iptables \
--table nat \
--append POSTROUTING \
--source 10.0.0.0/24 \
--out-interface enp0s31f6 \
--jump MASQUERADE
