# DIY Router

Scripts and config files for use on Arch. It's very specific for my router hardware.

## North Star
As manual as I find palatable, which is generally pretty manual but staying in userland


## Linux
The kernel itself needs one setting enabled

Put [ip-forward.conf](ip-forward.conf) in `/etc/sysctl.d/`

## Two NICs

### intel
192.168.0.222/24

IP on upstairs network. DHCP server goes up to and includes .200.

### realtek
10.0.0.1/24

It is .1 because it's the gateway.


## DNS
Router `/etc/resolv.conf` is pointing to CloudFlare 1.1.1.1 although it is ignored by dnsmasq

Laptop `/etc/resolv.conf` is configured via DHCP via dnsmasq

https://wiki.archlinux.org/title/Dnsmasq


## qualcomm
The qualcomm card is turned into an AP with `hostapd`. The question of how to link the wifi layer 2 with the integrated NIC is a bridge network? I think the wifi and nic2 are bridged together?
https://wiki.archlinux.org/title/Network_bridge

If you run `iw list` it shows the qualcomm has two "bands", and those refer to 2.4Ghz and 5Ghz

https://wiki.archlinux.org/title/Software_access_point

Here are all the `hostapd.conf` flags https://w1.fi/cgit/hostap/plain/hostapd/hostapd.conf

systemd-networkd uses hostapd underneath. I can skip the middle man and use hostapd. I don't need systemd at all really but I think Arch is still the best choice. I just won't use systemd-networkd for now.


## Potential features
* Firewall - if the box isnt internet facing then this can wait
* Wireguard
* mitm-proxy
* PiKVM
* DNS encryption
* IPv6
* Tailscale

## Out of scope
* non-root user
* systemd-networkd
* crypto
