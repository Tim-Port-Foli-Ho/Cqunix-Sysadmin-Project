#!/bin/bash

# --- Configuration ---
TARGET_HOST="sydney"
TARGET_IP="192.168.100.50"
TARGET_USER="a"
SOURCE_DIRS=("/etc/ssh/" "/etc/fail2ban/")
# --- End Configuration ---

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_ROOT="/backups/${TARGET_HOST}"
CURRENT_BACKUP_DIR="${BACKUP_ROOT}/${TIMESTAMP}"
LOG_FILE="${CURRENT_BACKUP_DIR}/backup_log.txt"

sudo mkdir -p "${CURRENT_BACKUP_DIR}"
sudo chown a:a "${CURRENT_BACKUP_DIR}"

echo "--- Backup of ${TARGET_HOST} started at: $(date) ---" > "${LOG_FILE}"

rsync -avz --delete -e ssh ${TARGET_USER}@${TARGET_IP}:${SOURCE_DIRS[0]} "${CURRENT_BACKUP_DIR}/ssh/" >> "${LOG_FILE}" 2>&1
rsync -avz --delete -e ssh ${TARGET_USER}@${TARGET_IP}:${SOURCE_DIRS[1]} "${CURRENT_BACKUP_DIR}/fail2ban/" >> "${LOG_FILE}" 2>&1

echo "" >> "${LOG_FILE}"
echo "--- File list from backup ---" >> "${LOG_FILE}"
find "${CURRENT_BACKUP_DIR}" -ls >> "${LOG_FILE}"

echo "" >> "${LOG_FILE}"
echo "--- Backup finished at: $(date) ---" >> "${LOG_FILE}"

echo "Backup of ${TARGET_HOST} complete. Log file: ${LOG_FILE}"