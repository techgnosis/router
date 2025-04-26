# DIY Router

North Star - as manual as I find palatable, which is generally pretty manual but staying in userland

## Quick Setup
Look at `setup.sh` for all the steps


## Linux
The kernel itself needs one setting enabled

Put [99-ip-forward.conf](99-ip-forward.conf) in `/etc/sysctl.d/`

## Two NICs

### intel
192.168.0.0/24

Gets IP from upstairs router

### realtek
10.0.0.1/24

It is .1 because it's the gateway.


## DNS
Router has `/etc/resolv.conf` pointing to upstairs router

Laptop `/etc/resolv.conf` points to upstairs router because the router has no DNS forwarder

## qualcomm
The qualcomm card is turned into an AP with `hostapd`. The question of how to link the wifi layer 2 with the integrated NIC is a bridge network? I think the wifi and nic2 are bridged together?

https://wiki.archlinux.org/title/Software_access_point

Here are all the `hostapd.conf` flags https://w1.fi/cgit/hostap/plain/hostapd/hostapd.conf

systemd-networkd uses hostapd underneath. I can skip the middle man and use hostapd. I don't need systemd at all really but I think Arch is still the best choice. I just won't use systemd-networkd for now.


## Out of scope for V1
* DHCP - just manually assign the IP on the client for now
* DNS - use upstairs router for now
* Firewall - if the box isnt internet facing then this can wait
* NAT - I don't need NAT until I am internet facing
* systemd-networkd - just setup IP manually, it's more fun. Don't reboot! :)
* Wireguard - cool idea for later
* GPU mining - if this becomes internet facing then I can mine and do real P2P
* LLM hosting
* mitm-proxy
* PiKVM
