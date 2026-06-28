#!/bin/bash
set -euo pipefail

LOG_FILE="${1:-nginx-access.log}"

if [ ! -f "$LOG_FILE" ]; then
  echo "Error: log file '$LOG_FILE' not found." >&2
  echo "Usage: $(basename "$0") [log-file]" >&2
  exit 1
fi

TOTAL=$(wc -l < "$LOG_FILE")
echo "Log file:      $LOG_FILE"
echo "Total requests: $TOTAL"

echo ""
echo "Top 5 IP addresses:"
awk '{print $1}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn | head -5 \
  | awk '{printf "  %-20s %s requests\n", $2, $1}'

echo ""
echo "Top 5 requested paths:"
awk '{print $7}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn | head -5 \
  | awk '{printf "  %-40s %s requests\n", $2, $1}'

echo ""
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn | head -5 \
  | awk '{printf "  %s   %s requests\n", $2, $1}'

echo ""
echo "Top 5 user agents:"
awk -F'"' '{if ($6 != "" && $6 != "-") print $6}' "$LOG_FILE" \
  | sort | uniq -c | sort -rn | head -5 \
  | awk '{
      line = substr($0, index($0,$2))
      printf "  [%s] %s\n", $1, line
    }'
