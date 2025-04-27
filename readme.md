# DIY Router

Scripts and config files for use on Arch. It's very specific for my router hardware.

## North Star
As manual as I find palatable, which is generally pretty manual but staying in userland


## Packet forwarding
You need to enable packet forwarding in the kernel with `sysctl` by putting [ip-forward.conf](ip-forward.conf) in `/etc/sysctl.d/`

## NICs

### intel
192.168.0.222/24

IP on upstairs network. DHCP server goes up to and includes .200.

### realtek
10.0.0.1/24

It is .1 because it's the gateway.

### qualcomm
The qualcomm card is turned into an AP with `hostapd`. The AP itself doesn't have an IP address so the qualcomm is bridged with the realtek

https://wiki.archlinux.org/title/Software_access_point

https://w1.fi/cgit/hostap/plain/hostapd/hostapd.conf

https://wiki.archlinux.org/title/Network_bridge


## DNS
Router `/etc/resolv.conf` is pointing to CloudFlare 1.1.1.1 although it is ignored by dnsmasq

Laptop `/etc/resolv.conf` is configured via DHCP via dnsmasq

https://wiki.archlinux.org/title/Dnsmasq


## iptables

Minimal rules
* Block all incoming traffic except for existing outbound connections
* NAT the internet bound traffic

https://linux.die.net/man/8/iptables


## mitmproxy

You can run `mitm.sh` to use "transparent" mode. It will create some iptables rules and then run mitmweb to receive traffic from those rules. When the script is ended the iptables rules are flushed.

You still need the host that is creating the HTTP requests to trust the mitmproxy CA, which you can get from [mitmweb](http://10.0.0.1:8081/?token=mitm)



## Potential features
* Wireguard
* PiKVM
* DNS encryption
* IPv6
* Tailscale
* content blocking

## Out of scope
* non-root user
* systemd-networkd
* crypto

## TODO
* initramfs images seem to be not working
