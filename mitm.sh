#!/usr/bin/env bash

set -euo pipefail

function handle_sigint() {
    echo "Flushing iptables"
    iptables --table nat --flush PREROUTING
}

trap handle_sigint SIGINT

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

mitmweb \
--mode transparent \
--no-web-open-browser \
--web-port 8081 \
--web-host 10.0.0.1 \
--set web_password='mitm'
