#!/bin/sh

echo "=== CPU Usage ==="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

echo "=== Memory Usage ==="
free -h | awk 'NR==2{printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2*100}'

echo "=== Disk Usage ==="
df -h --total | awk '/total/ {printf "Used: %s / Total: %s (%s)\n", $3, $2, $5}'

echo "=== Top 5 Processes by CPU Usage ==="
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo "=== Top 5 Processes by Memory Usage ==="
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 

echo "=== Additional Stats ==="
echo "OS Version: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F 'load average:' '{print $2}' | xargs)"
echo "Logged in Users: $(who | wc -l)"
