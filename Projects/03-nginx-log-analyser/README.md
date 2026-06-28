# Nginx Log Analyser

A Bash script that parses an Nginx access log in Combined Log Format and prints the top 5 results across four categories: IP addresses, request paths, response status codes, and user agents.

## Requirements

- Linux or macOS
- `bash`, `awk`, `sort`, `uniq`, `wc`
- An Nginx access log in Combined Log Format

## Usage

```bash
chmod +x nginx_log_analyzer.sh

# Use the bundled sample log
./nginx_log_analyzer.sh nginx-access.log

# Or point to any access log
./nginx_log_analyzer.sh /var/log/nginx/access.log
```

If no argument is given, the script defaults to `nginx-access.log` in the current directory.

## Output

```
Log file:       nginx-access.log
Total requests: 10000

Top 5 IP addresses:
  178.128.94.113       1087 requests
  142.93.136.176        919 requests
  ...

Top 5 requested paths:
  /v1-health                               4560 requests
  /v1-users                                1023 requests
  ...

Top 5 response status codes:
  200   5740 requests
  404    312 requests
  ...

Top 5 user agents:
  [4560] DigitalOcean Uptime Probe 0.22.0 (https://digitalocean.com)
  [312]  Mozilla/5.0 (compatible; Googlebot/2.1; ...)
  ...
```

## How It Works

The script reads each line of the log and extracts fields using `awk`. Nginx's Combined Log Format is:

```
$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"
```

| Field | Column | Extraction |
|-------|--------|------------|
| IP address | `$1` | `awk '{print $1}'` |
| Request path | `$7` | `awk '{print $7}'` |
| Status code | `$9` | `awk '{print $9}'` |
| User agent | 6th `"` | `awk -F'"' '{print $6}'` |

Each field is then piped through `sort | uniq -c | sort -rn | head -5` to find the top 5 by frequency. Empty and `-` user agent values are filtered out.

## Files

```
03-nginx-log-analyser/
  nginx_log_analyzer.sh   Main script
  nginx-access.log        Sample log with ~10,000 lines for testing
  README.md
```

## Reference

[roadmap.sh — Nginx Log Analyser](https://roadmap.sh/projects/nginx-log-analyser)
