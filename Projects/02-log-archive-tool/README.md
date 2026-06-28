# Log Archive Tool

A Bash script that compresses a directory of logs into a timestamped `.tar.gz` archive and records each operation to an audit log.

## Requirements

- Linux or macOS
- `bash`, `tar`
- Write access to the current working directory

## Installation

To make the script available system-wide:

```bash
sudo cp log-archive.sh /usr/local/bin/log-archive
sudo chmod +x /usr/local/bin/log-archive
```

## Usage

```bash
./log-archive.sh <log-directory>
```

### Example

```bash
./log-archive.sh /var/log
```

Output:

```text
Archive created: /home/user/archives/logs_archive_20241004_143022.tar.gz
```

## How It Works

1. Validates that exactly one argument is provided.
2. Checks that the target directory exists.
3. Creates an `archives/` directory in the current working directory if it does not exist.
4. Compresses the entire log directory into `archives/logs_archive_<YYYYMMDD_HHMMSS>.tar.gz`.
5. Appends a timestamped entry to `archives/archive.log` for auditing.

## Archive Structure

```text
archives/
  logs_archive_20241004_143022.tar.gz
  logs_archive_20241005_020001.tar.gz
  archive.log
```

The `archive.log` file contains one line per run:

```text
[2024-10-04 14:30:22] Archived '/var/log' -> '/home/user/archives/logs_archive_20241004_143022.tar.gz'
```

## Automating with cron

To archive `/var/log` every night at midnight:

```bash
crontab -e
```

Add:

```text
0 0 * * * /usr/local/bin/log-archive /var/log
```

## Notes

- The script uses `set -euo pipefail` so it exits immediately on any error.
- If the log directory contains files owned by root (e.g., `/var/log/auth.log`), run the script with `sudo`.

## Reference

[roadmap.sh — Log Archive Tool](https://roadmap.sh/projects/log-archive-tool)
