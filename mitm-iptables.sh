#!/usr/bin/env bash

set -euo pipefail

iptables \
--table nat \
--flush PREROUTING

iptables \
--table nat \
--append PREROUTING \
--in-interface br0 \
--protocol tcp \
--destination-port 80 \
--jump REDIRECT \
--to-port 8080

iptables \
--table nat \
--append PREROUTING \
--in-interface br0 \
--protocol tcp \
--destination-port 443 \
--jump REDIRECT \
--to-port 8080
