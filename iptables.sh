#!/usr/bin/env bash

set -euxo pipefail

iptables \
--table filter \
--flush INPUT

iptables \
--table filter \
--policy INPUT DROP

iptables \
--table filter \
--append INPUT \
--in-interface lo \
--jump ACCEPT

iptables \
--table filter \
--append INPUT \
--match state \
--state ESTABLISHED,RELATED \
--jump ACCEPT





iptables \
--tables filter \
--policy FORWARD DROP

iptables \
--tables filter \
--append FORWARD \
--in-interface br0 \
--jump ACCEPT

iptables \
--tables filter \
--append FORWARD \
--in-interface enp0s31f6 \
--match state \
--state ESTABLISHED,RELATED \
--jump ACCEPT






iptables \
--tables filter \
--policy OUTPUT DROP

iptables \
--tables filter \
--append OUTPUT \
--destination 1.1.1.1 \
--jump ACCEPT




iptables \
--table nat \
--flush POSTROUTING

iptables \
--table nat \
--append POSTROUTING --source 10.0.0.0/24 --out-interface enp0s31f6 --jump MASQUERADE
