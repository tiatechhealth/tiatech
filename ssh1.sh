ssh -p 8042 root@117.193.76.178 << EOF
uname -a
lscpu  | grep "^CPU(s)"
grep -i mem
ps -ef | grep 5430
free -m | cat /proc/loadavg
EOF

