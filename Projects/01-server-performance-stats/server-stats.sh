#!/bin/bash
set -euo pipefail

echo "=== CPU Usage ==="
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

echo ""
echo "=== Memory Usage ==="
free -m | awk 'NR==2{
  used=$3; total=$2; pct=used/total*100
  printf "Used: %dMB / Total: %dMB (%.2f%%)\n", used, total, pct
}'

echo ""
echo "=== Disk Usage ==="
df -h --total | awk '/total/ {printf "Used: %s / Total: %s (%s)\n", $3, $2, $5}'

echo ""
echo "=== Top 5 Processes by CPU Usage ==="
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ""
echo "=== Top 5 Processes by Memory Usage ==="
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo ""
echo "=== System Info ==="
OS=$(grep -m1 PRETTY_NAME /etc/os-release 2>/dev/null | cut -d'"' -f2 \
  || lsb_release -d 2>/dev/null | cut -f2 \
  || echo "Unknown")
echo "OS:           $OS"
echo "Uptime:       $(uptime -p)"
echo "Load Average: $(uptime | awk -F 'load average:' '{print $2}' | xargs)"
echo "Logged Users: $(who | wc -l)"
