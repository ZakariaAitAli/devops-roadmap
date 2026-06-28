# Server Performance Stats

A Bash script that reports key performance metrics from any Linux server: CPU, memory, disk, top processes, and system info.

## Requirements

- Linux (any distribution with `bash`, `top`, `free`, `df`, `ps`, `uptime`; `/etc/os-release` or `lsb_release` for OS name)
- Run as a user with read access to process information

## Usage

```bash
chmod +x server-stats.sh
./server-stats.sh
```

## Output

```text
=== CPU Usage ===
CPU Usage: 12.5%

=== Memory Usage ===
Used: 1024MB / Total: 3840MB (26.67%)

=== Disk Usage ===
Used: 8.5G / Total: 20G (44%)

=== Top 5 Processes by CPU Usage ===
  PID COMMAND         %CPU
 1234 node            12.3
  ...

=== Top 5 Processes by Memory Usage ===
  PID COMMAND         %MEM
 1234 node             5.1
  ...

=== System Info ===
OS:           Ubuntu 22.04.3 LTS
Uptime:       up 3 days, 4 hours, 22 minutes
Load Average:  0.45, 0.38, 0.31
Logged Users: 2
```

## Notes

- Memory is reported in MB using `free -m`, which avoids floating-point issues with human-readable suffixes.
- Disk usage aggregates all mounted filesystems via `df --total`.
- The script exits immediately on any command failure (`set -euo pipefail`).

## Reference

[roadmap.sh — Server Performance Stats](https://roadmap.sh/projects/server-stats)
