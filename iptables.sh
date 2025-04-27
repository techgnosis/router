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
--table filter \
--append INPUT \
--match udp \
--protocol udp \
--destination-port 53 \
--jump ACCEPT

iptables \
--table filter \
--append INPUT \
--jump LOG \
--match limit \
--limit-burst 1 \
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
--log-prefix "FORWARD_DROP:" \
--log-level info




iptables \
--table filter \
--flush OUTPUT

# iptables \
# --table filter \
# --policy OUTPUT DROP

# iptables \
# --table filter \
# --append OUTPUT \
# --destination-port 53 \
# --jump ACCEPT

# # ntp
# iptables \
# --table filter \
# --append OUTPUT \
# --protocol udp \
# --destination-port 123 \
# --jump ACCEPT

# # package updates
# iptables \
# --table filter \
# --append OUTPUT \
# --protocol tcp \
# --match multiport \
# --destination-ports 80,443 \
# --jump ACCEPT

# iptables \
# --table filter \
# --append OUTPUT \
# --jump LOG \
# --match limit \
# --limit-burst 1 \
# --log-prefix "OUTPUT_DROP:" \
# --log-level info




iptables \
--table nat \
--flush POSTROUTING

iptables \
--table nat \
--append POSTROUTING --source 10.0.0.0/24 --out-interface enp0s31f6 --jump MASQUERADE
