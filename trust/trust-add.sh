#! /usr/bin/env bash

set -euo pipefail

sudo security add-trusted-cert -d -p ssl -p basic mitmproxy-ca-cert.pem
