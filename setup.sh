#! /usr/bin/env bash

set -euo pipefail


cp ip-forward.conf /etc/sysctl.d/

cp resolv.conf /etc/

cp hostapd.conf /etc/hostapd/

./intel-up.sh

./realtek-up.sh

./routes.sh