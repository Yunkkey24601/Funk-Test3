#!/bin/sh
OUT=/tmp/r.txt
{
echo "=== SUID/SGID ==="
find / -perm -4000 -o -perm -2000 2>/dev/null | head -40
echo "=== SUDO ==="
sudo -n -l 2>&1
echo "=== WRITABLE ROOT-EXEC PATHS ==="
ls -la /var/cw/ansible/scripts/ 2>&1
find /var/cw -writable 2>/dev/null | head
find / -maxdepth 4 -writable -user root 2>/dev/null | grep -vE '/proc|/sys' | head -30
echo "=== CRON (root jobs w/ writable inputs) ==="
ls -la /etc/cron* 2>&1; cat /etc/crontab 2>&1
echo "=== ANSIBLE SCRIPTS DIR (readable playbooks?) ==="
find /var/cw/ansible/scripts /var/cw/ansible/stats -readable -type f 2>/dev/null | head -30
cat /var/cw/ansible/scripts/*.sh 2>&1 | head -60
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
echo "=== ORCHESTRATION INPUT SURFACE ==="
cat /home/1674776.cloudwaysapps.com/*/conf/server.nginx 2>&1 | head -30
env | grep -iE 'label|repo|app_name|branch|commit'
echo "=== DONE ==="
} > $OUT 2>&1
cat $OUT
