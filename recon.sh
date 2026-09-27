echo "=== yacekrhhcs identity ==="
grep yacekrhhcs /etc/passwd
ls -la /home/1674776.cloudwaysapps.com/yacekrhhcs/ 2>&1
ls -la /home/1674776.cloudwaysapps.com/yacekrhhcs/git_repo/ 2>&1
cat /home/1674776.cloudwaysapps.com/yacekrhhcs/git_repo/package.json 2>&1 | head
cat /home/1674776.cloudwaysapps.com/yacekrhhcs/conf/server.nginx 2>&1 | grep -i server_name
echo "=== all app-users + when ==="
ls -la /home/1674776.cloudwaysapps.com/
grep -E '/home/1674776' /etc/passwd
