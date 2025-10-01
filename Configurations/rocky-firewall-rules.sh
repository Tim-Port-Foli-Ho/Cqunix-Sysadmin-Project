#!/bin/bash

#Apply to Rocky 
#This script configures iptables rules and NAT 
#Interface enp0s8 is the external interface (connected to the internet).
#Interface enp0s3 is the internal network interface.

echo “starting”

#remove existing rules
iptables -F
iptables -t nat -F
iptables -X

#Set default policies, drop all input and forward traffic without a matching rule 
#Accept any outgoing
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#allow loopback interface
iptables -A INPUT -i lo -j ACCEPT

#allow reverse connections (established and related)
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#forward internal network through Rocky
iptables -A FORWARD -i enp0s3 -o enp0s8 -j ACCEPT

#enable NAT from internal to external
iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

#allow SSH access to Rocky from internal network
iptables -A INPUT -i enp0s3 -p tcp --dport 22 -j ACCEPT

# Allow SSH traffic to internal SSH server (Sydney) from the internet
iptables -A FORWARD -p tcp -d 192.168.100.50 --dport 22 -j ACCEPT

#improved logging (optional)
# iptables -A INPUT -j LOG --log-prefix "iptables-dropped: " --log-level 4

echo "IPTables rules applied"
