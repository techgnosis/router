#! /usr/bin/env bash

set -euo pipefail

nft add table ip filter

nft add chain ip filter input '{ type filter hook input priority 0; policy drop; }'

nft add rule ip filter input iif lo accept

nft add rule ip filter input iif br0 accept

