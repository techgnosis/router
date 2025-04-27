#! /usr/bin/env bash

set -euxo pipefail


iptables --policy INPUT ACCEPT
iptables --policy FORWARD ACCEPT
iptables --policy OUTPUT ACCEPT

iptables --table filter --flush
iptables --table nat --flush

iptables --table filter --delete-chain
iptables --table nat --delete-chain

iptables \
--table nat \
--flush POSTROUTING

iptables \
--table nat \
--append POSTROUTING \
--source 10.0.0.0/24 \
--out-interface enp0s31f6 \
--jump MASQUERADE
