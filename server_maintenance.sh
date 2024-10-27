#!/bin/bash
ID="25438"
MAIN_DIR="$HOME/ServerMaintenance_$ID"

echo "Creating directory structure..."
mkdir -p "$MAIN_DIR/logs" "$MAIN_DIR/backups" "$MAIN_DIR/cleanups"
echo "Directory structure created at: $MAIN_DIR"

LOG_FILE="$MAIN_DIR/logs/system_logs_${ID}_$(date +%Y%m%d).log"
echo "Generating log file: $LOG_FILE"

for i in {1..100}; do
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  EVENT_TYPE=$(shuf -n 1 -e INFO WARNING ERROR)
  MESSAGE="Random log number $i"
  echo "[$TIMESTAMP] [$EVENT_TYPE] [$MESSAGE]" >> "$LOG_FILE"
done
echo "100 log entries added to $LOG_FILE."

echo "Organizing logs by event type..."
grep "\[INFO\]" "$LOG_FILE" > "$MAIN_DIR/logs/info_logs_${ID}.log"
grep "\[WARNING\]" "$LOG_FILE" > "$MAIN_DIR/logs/warning_logs_${ID}.log"
grep "\[ERROR\]" "$LOG_FILE" > "$MAIN_DIR/logs/error_logs_${ID}.log"
echo "Logs separated into INFO, WARNING, and ERROR."

BACKUP_FILE="$MAIN_DIR/backups/logs_backup_${ID}_$(date +%Y%m%d).tar.gz"
echo "Creating backup: $BACKUP_FILE"
tar -czf "$BACKUP_FILE" -C "$MAIN_DIR/logs" .
echo "Backup created successfully."

echo "Cleaning up old logs..."

find "$MAIN_DIR/logs" -type f -mtime +7 -exec rm {} \;
echo "Deleted logs older than 7 days."

find "$MAIN_DIR/logs" -type f -mmin +5 -exec mv {} "$MAIN_DIR/cleanups" \;
echo "Moved logs older than 5 minutes to the cleanups directory."

EXECUTION_LOG="$MAIN_DIR/logs/maintenance_script_log_${ID}.log"
echo "Logging script execution..."
echo "Script executed at: $(date +"%Y-%m-%d %H:%M:%S")" >> "$EXECUTION_LOG"
echo "Execution logged to: $EXECUTION_LOG"

echo "All tasks completed successfully."
