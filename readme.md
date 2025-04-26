Making my own router is still the best option I have for a meaningful project.

Linux kernel

sudo sysctl net.ipv4.ip_forward=1
or
sudo nano /etc/sysctl.d/99-ip-forward.conf
`net.ipv4.ip_forward=1`

## Two NICs

## NIC1
192.168.0.0/24
Gets IP from upstairs router
### NIC2
10.0.0.1/24
It is .1 because it's the gateway.

Plug a switch into NIC2

Laptop plugs into the switch. Laptop assigns itself 10.0.0.2

Router has /etc/resolv.conf pointing to upstairs router
Laptop /etc/resolv.conf points to upstairs router




# Out of scope for V1
DHCP - just manually assign the IP on the client for now
DNS - use upstairs router for now
Firewall - if the box isnt internet facing then this can wait
NAT - I don't need NAT until I am internet facing
systemd-networkd - just setup IP manually



Laptop NIC -> Switch -> NIC2 -> route table -> NIC1

systemd-networkd uses hostapd underneath. I can skip the middle man and use hostapd. I don't need systemd at all really but I think Arch is still the best choice. I just won't use systemd-networkd for now.