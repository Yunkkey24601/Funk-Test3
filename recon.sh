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
id
