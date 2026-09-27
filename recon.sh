echo "=== ARP (passive neighbors) ==="
cat /proc/net/arp
echo "=== CLOUD-INIT INSTANCE DATA ==="
cat /run/cloud-init/instance-data.json 2>/dev/null | head -100
echo "=== NETPLAN/DHCP ==="
cat /etc/netplan/*.yaml 2>/dev/null; ls -la /var/lib/dhcp/ 2>/dev/null; cat /var/lib/dhcp/* 2>/dev/null | head
echo "=== LISTENERS (full, with process) ==="
ss -ltnp 2>/dev/null
echo "=== SERVICE FINGERPRINT :8084 :4200 :3500 ==="
for p in 8084 4200 3500; do echo "--$p"; curl -sk --max-time 3 https://localhost:$p/ 2>&1 | head -15; curl -s --max-time 3 http://localhost:$p/ 2>&1 | head -15; done
cat /etc/systemd/system/*.service 2>/dev/null | grep -iE '8084|4200|3500|ExecStart' | head
ls -la /proc/*/exe 2>/dev/null | grep -iE 'cloudways|agent' | head
