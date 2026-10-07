echo "=== GIT CHECKOUT OWNERSHIP ==="
ls -la ~/git_repo/ 2>&1 | head
ls -la ~/git_repo/.git/ 2>&1 | head
stat -c '%U %G %n' ~/git_repo ~/git_repo/.git 2>&1
echo "=== WHO RAN GIT (recent root procs?) ==="
ps aux 2>/dev/null | grep -iE 'git|ansible' | grep -v grep
echo "=== HOOKS DIR WRITABLE BY ME? ==="
ls -la ~/git_repo/.git/hooks/ 2>&1 | head
touch ~/git_repo/.git/hooks/_wtest 2>&1 && echo "HOOKS WRITABLE" || echo "hooks not writable"
echo "=== BUILD USER ==="
idecho "=== yacekrhhcs identity ==="
grep yacekrhhcs /etc/passwd
ls -la /home/1674776.cloudwaysapps.com/yacekrhhcs/ 2>&1
ls -la /home/1674776.cloudwaysapps.com/yacekrhhcs/git_repo/ 2>&1
cat /home/1674776.cloudwaysapps.com/yacekrhhcs/git_repo/package.json 2>&1 | head
cat /home/1674776.cloudwaysapps.com/yacekrhhcs/conf/server.nginx 2>&1 | grep -i server_name
echo "=== all app-users + when ==="
ls -la /home/1674776.cloudwaysapps.com/
grep -E '/home/1674776' /etc/passwd
