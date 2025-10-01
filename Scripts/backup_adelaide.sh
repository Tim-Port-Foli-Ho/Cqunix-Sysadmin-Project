#!/bin/bash

# --- Configuration ---
TARGET_HOST="adelaide"
TARGET_IP="192.168.100.100"
# user 'a' is admin
TARGET_USER="a"
SOURCE_DIRS=("/var/www/html/dokuwiki/" "/etc/apache2/")

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_ROOT="/backups/${TARGET_HOST}"
CURRENT_BACKUP_DIR="${BACKUP_ROOT}/${TIMESTAMP}"
LOG_FILE="${CURRENT_BACKUP_DIR}/backup_log.txt"
# --- End Configuration ---

# Create the timestamped directory for the new backup
sudo mkdir -p "${CURRENT_BACKUP_DIR}"
sudo chown a:a "${CURRENT_BACKUP_DIR}"

echo "--- Backup of ${TARGET_HOST} started at: $(date) ---" > "${LOG_FILE}"

# Use rsync to pull files from the target server
rsync -avz --delete -e ssh ${TARGET_USER}@${TARGET_IP}:${SOURCE_DIRS[0]} "${CURRENT_BACKUP_DIR}/dokuwiki/" >> "${LOG_FILE}" 2>&1
rsync -avz --delete -e ssh ${TARGET_USER}@${TARGET_IP}:${SOURCE_DIRS[1]} "${CURRENT_BACKUP_DIR}/apache2/" >> "${LOG_FILE}" 2>&1

echo "" >> "${LOG_FILE}"
echo "--- File list from backup ---" >> "${LOG_FILE}"
find "${CURRENT_BACKUP_DIR}" -ls >> "${LOG_FILE}"

echo "" >> "${LOG_FILE}"
echo "--- Backup finished at: $(date) ---" >> "${LOG_FILE}"

echo "Backup of ${TARGET_HOST} complete. Log file: ${LOG_FILE}"