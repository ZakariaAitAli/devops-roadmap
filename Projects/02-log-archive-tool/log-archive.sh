#!/bin/bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $(basename "$0") <log-directory>" >&2
  exit 1
fi

LOG_DIR=$(realpath "$1")
ARCHIVE_DIR=$(realpath -m "$PWD/archives")
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="${ARCHIVE_DIR}/archive.log"

if [ ! -d "$LOG_DIR" ]; then
  echo "Error: directory '$LOG_DIR' does not exist." >&2
  exit 1
fi

# Prevent tar from recursing into its own output directory
case "$ARCHIVE_DIR" in
  "$LOG_DIR" | "$LOG_DIR"/*)
    echo "Error: archive directory '$ARCHIVE_DIR' is inside the source directory '$LOG_DIR'." >&2
    echo "Run the script from a directory outside the log tree." >&2
    exit 1
    ;;
esac

mkdir -p "$ARCHIVE_DIR"

tar -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" -C "$LOG_DIR" .

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived '$LOG_DIR' -> '${ARCHIVE_DIR}/${ARCHIVE_NAME}'" >> "$LOG_FILE"

echo "Archive created: ${ARCHIVE_DIR}/${ARCHIVE_NAME}"
