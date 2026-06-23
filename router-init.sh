#!/bin/sh
apk update
apk add iptables iproute2

echo 1 > /proc/sys/net/ipv4/ip_forward

# NAT for prod nodes
iptables -t nat -A POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE

# L2/L3 isolation between prod nodes
iptables -A FORWARD -s 192.168.100.2 -d 192.168.100.3 -j DROP
iptables -A FORWARD -s 192.168.100.3 -d 192.168.100.2 -j DROP

tail -f /dev/null
