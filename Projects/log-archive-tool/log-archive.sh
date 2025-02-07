#!/bin/bash

# Validate Input
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="$PWD/archives"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="${ARCHIVE_DIR}/archive_log.txt"

# Check if log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Compress logs
sudo tar -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" -C "$LOG_DIR" .

# Log the operation
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived $LOG_DIR to $ARCHIVE_DIR/$ARCHIVE_NAME" >> "$LOG_FILE"

echo "Logs successfully archived: $ARCHIVE_DIR/$ARCHIVE_NAME"