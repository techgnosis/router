#!/usr/bin/env bash

set -euo pipefail

# 1. Set the default policy for the INPUT chain to DROP.
#    This is the most secure starting point: block everything by default.
#    Any incoming packet not explicitly allowed by a subsequent rule will be dropped.
iptables --policy INPUT DROP


# 2. Allow loopback traffic.
#    Essential for applications on the router to talk to themselves using localhost (127.0.0.1).
iptables --append INPUT --in-interface lo --jump ACCEPT


# 3. Allow packets belonging to established connections or related to them.
#    This is CRUCIAL for allowing replies to traffic the router itself initiates outbound
#    (e.g., router checking for updates, router doing DNS lookups if it's configured as the upstream DNS server).
iptables --append INPUT --match state --state ESTABLISHED,RELATED --jump ACCEPT


# 4. Allow all traffic originating from the local network interface ($LOCAL_IFACE).
#    This allows clients on your local network to access services running on the router's local IP
#    (like DNS, DHCP requests if using dnsmasq, SSH if you set it up, ping, etc.).
#    This is necessary for the router to function as a local gateway and server for your clients.
iptables --append INPUT --in-interface br0 --jump ACCEPT
