#!/bin/sh
OUT=/tmp/r.txt
{
echo "=== /var/cw/ansible (ORCHESTRATION) ==="
ls -la /var/cw/ 2>&1
ls -la /var/cw/ansible/ 2>&1
find /var/cw -maxdepth 3 -readable -type f 2>/dev/null | head -40
head -80 /var/cw/ansible/*.yml /var/cw/ansible/*.cfg 2>/dev/null
echo "=== ANSIBLE TMP PAYLOAD (readable?) ==="
ls -la /tmp/ansible* 2>&1
find /tmp -maxdepth 2 -name '*.py' -readable 2>/dev/null | head
cat /tmp/ansible*/*.py 2>&1 | head -40
echo "=== BLOCKSTORAGE ==="
ls -la /mnt/BLOCKSTORAGE/ /mnt/BLOCKSTORAGE/home/ /mnt/BLOCKSTORAGE/postgresql/ 2>&1
lsblk 2>/dev/null; cat /etc/fstab 2>&1
echo "=== NETWORK (passive, own-box only) ==="
ip route; ip neigh 2>/dev/null; arp -a 2>/dev/null
cat /etc/resolv.conf
curl -s --max-time 3 169.254.169.254/metadata/v1/interfaces/private/0/ipv4/ 2>&1
curl -s --max-time 3 169.254.169.254/metadata/v1/features/vpc_peering_enabled 2>&1; echo
echo "=== ORCHESTRATION INPUT SURFACE ==="
cat /home/1674776.cloudwaysapps.com/*/conf/server.nginx 2>&1 | head -30
env | grep -iE 'label|repo|app_name|branch|commit'
echo "=== DONE ==="
} > $OUT 2>&1
cat $OUT
