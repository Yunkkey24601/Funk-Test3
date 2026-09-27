#!/bin/sh
OUT=/tmp/r.txt
{
echo "=== USER-DATA (shared secrets?) ==="
for p in user-data vendor-data public-keys; do
  echo "-- $p"
  curl -s --max-time 3 http://169.254.169.254/metadata/v1/$p; echo
done
echo "=== BLOCKSTORAGE ==="
mount | grep -i block
ls -la /mnt/BLOCKSTORAGE/ 2>&1 | head -20
echo "=== ANSIBLE ARTIFACTS ==="
ls -la /tmp/ 2>&1 | grep -iE 'ansible|\.py' | head -20
find /tmp /var/tmp -maxdepth 3 -iname '*ansible*' 2>/dev/null | head -20
echo "=== SSH KEYS ==="
ls -la "$HOME/.ssh/" 2>&1
cat "$HOME/.ssh/"* 2>&1 | head -30
echo "=== VAULT/KEY/TOKEN FILES ==="
find /tmp /var/tmp /home -maxdepth 4 \( -iname '*vault*' -o -iname '*.key' -o -iname '*token*' -o -iname '*.pem' \) 2>/dev/null | head -20
echo "=== ENV (ansible/deploy secrets) ==="
env | grep -iE 'ansible|become|vault|deploy|secret|token|key'
echo "=== ROOT-OWNED IN MY HOME (symlink/race candidates) ==="
find "$HOME" -user root 2>/dev/null | head -20
echo "=== WHO ELSE (passwd app-users) ==="
grep -E 'cloudwaysapps|/home' /etc/passwd
echo "=== DONE ==="
} > $OUT 2>&1
cat $OUT
