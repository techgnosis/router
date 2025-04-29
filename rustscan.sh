#! /usr/bin/env bash

set -euxo pipefail

rustscan \
--addresses 192.168.0.222 \
--scripts none \
--no-config \
--ulimit 5000 \
--scan-order "Random"
