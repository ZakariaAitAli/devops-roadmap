#!/bin/bash

LOG_FILE=${1:-access.log}  # Default to 'access.log' if no argument is given

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file not found!"
    exit 1
fi

echo "Analyzing log file: $LOG_FILE"

# Top 5 IPs
echo -e "\nTop 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2, "-", $1, "requests"}'

# Top 5 requested paths
echo -e "\nTop 5 most requested paths:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2, "-", $1, "requests"}'

# Top 5 response status codes
echo -e "\nTop 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2, "-", $1, "requests"}'

# Top 5 user agents
echo -e "\nTop 5 user agents:"
awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2, "-", $1, "requests"}'
