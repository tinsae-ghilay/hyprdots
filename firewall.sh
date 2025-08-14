#!/bin/bash

# Exit on error
set -e

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root (e.g. with sudo)."
    exit 1
fi

# Check if iptables is installed
if ! command -v iptables >/dev/null 2>&1; then
    echo "iptables not found."
    read -p "Install it now? (Y/N): " confirm
    [[ $confirm =~ ^[Yy]([Ee][Ss])?$ ]] || exit 1
    pacman -S iptables
    echo "Installed. Please run the script again."
    exit 0
fi

# Confirm user intent before applying firewall rules
echo "WARNING: This will reset and apply new iptables rules."
read -p "Continue? (Y/N): " confirm
[[ $confirm =~ ^[Yy]([Ee][Ss])?$ ]] || exit 1

echo "Resetting iptables rules..."

# Flush and delete existing rules and user-defined chains
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Create custom chains for TCP and UDP
iptables -N TCP
iptables -N UDP

# Allow all traffic on the loopback interface
iptables -A INPUT -i lo -j ACCEPT

# Allow established and related incoming traffic
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop invalid packets
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Rate-limit ICMP (ping) requests
iptables -A INPUT -p icmp -m limit --limit 1/second --limit-burst 4 -j ACCEPT

# Route new UDP and TCP connections to their respective chains
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# Block legacy or unused TCP ports by rejecting connections

# Telnet (port 23)
iptables -A TCP -p tcp --dport 23 -j REJECT

# RPC/Portmapper (port 111)
iptables -A TCP -p tcp --dport 111 -j REJECT

# NetBIOS (ports 137-139)
iptables -A TCP -p tcp --dport 137:139 -j REJECT

# SMB (port 445)
iptables -A TCP -p tcp --dport 445 -j REJECT

# rlogin (port 513)
iptables -A TCP -p tcp --dport 513 -j REJECT

# X11 (ports 6000–6063)
iptables -A TCP -p tcp --dport 6000:6063 -j REJECT

# Explicitly block SSH (port 22)
iptables -A TCP -p tcp --dport 22 -j DROP

# Reject any remaining unmatched UDP or TCP traffic
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset

# Reject all other unmatched protocols
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

# Save the firewall rules to disk
iptables-save > /etc/iptables/iptables.rules

# Enable and start iptables service
systemctl enable iptables
systemctl restart iptables
systemctl status iptables --no-pager

echo "Firewall rules applied and iptables service started."
