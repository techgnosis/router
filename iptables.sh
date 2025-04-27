#!/usr/bin/env bash

set -euxo pipefail

iptables --table filter --flush INPUT

iptables --table filter --policy INPUT DROP

iptables --table filter --append INPUT --in-interface lo --jump ACCEPT

iptables --table filter --append INPUT --match state --state ESTABLISHED,RELATED --jump ACCEPT

iptables --table filter --append INPUT --in-interface br0 --jump ACCEPT


iptables --table nat --flush POSTROUTING

iptables --table nat --append POSTROUTING --source 10.0.0.0/24 --out-interface enp0s31f6 --jump MASQUERADE
