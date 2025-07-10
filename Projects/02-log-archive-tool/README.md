# Log Archive Tool

## Description
The Log Archive Tool is a simple command-line utility that allows users to archive logs from a specified directory. The tool compresses log files into a `.tar.gz` archive, storing them in a dedicated `archives` folder within the current working directory. This helps in maintaining system cleanliness while preserving logs for future reference.

## Features
- Archives logs from a given directory.
- Saves compressed logs in an `archives` folder.
- Names archives with a timestamp (e.g., `logs_archive_YYYYMMDD_HHMMSS.tar.gz`).
- Logs each archive operation with date and time.

## Requirements
- A Unix-based system (Linux/macOS).
- `tar` command must be available.
- Sufficient permissions to read logs and create archives.

## Installation
To make the script accessible from anywhere, move it to `/usr/local/bin/` and grant execution permissions:

```sh
sudo mv log-archive.sh /usr/local/bin/log-archive
sudo chmod +x /usr/local/bin/log-archive
```

## Usage
Run the command with a log directory as an argument:

```sh
log-archive <log-directory>
```

### Example
```sh
log-archive /var/log
```
Output:
```
Logs successfully archived: /current/directory/archives/logs_archive_YYYYMMDD_HHMMSS.tar.gz
```

## How It Works
1. The tool validates the input and checks if the log directory exists.
2. Creates an `archives` folder in the current working directory if it doesn’t exist.
3. Compresses the log files using `tar`.
4. Logs the archive operation with a timestamp.

## Advanced Features (Future Enhancements)
- Automate archiving with a cron job:
  ```sh
  0 0 * * * /usr/local/bin/log-archive /var/log
  ```
- Email notifications after archiving.
- Upload archived logs to cloud storage.

## License
This project is open-source and available for use and modification.

