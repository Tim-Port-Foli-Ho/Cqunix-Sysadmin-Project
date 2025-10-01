#!/bin/bash
# This script mirrors the local dokuwiki-pages repo to an external provider.

# --- CONFIGURATION ---
GITEA_USER="git" # The system user Gitea runs as
# Path to Gitea's bare repository on disk. Gitea's structure is /path/to/repos/OWNER/REPO_NAME.git
DOKUWIKI_REPO_PATH="/var/lib/gitea/data/gitea-repositories/tim/dokuwiki-pages.git" # IMPORTANT: 'tim' is your Gitea admin username. Change if different.
EXTERNAL_REPO_URL="git@github.com:YourUser/cqunix-dokuwiki-backup.git" # IMPORTANT: Change this to your actual external repo SSH URL!
LOG_FILE="/var/log/gladstone_external_sync.log"
# --- END CONFIGURATION ---

echo "---" >> "${LOG_FILE}"
echo "$(date): Starting sync to external git provider." >> "${LOG_FILE}"

# Execute git commands as the 'git' user in the repository's directory
# The 'git' user needs SSH key access to the external repo
sudo -u ${GITEA_USER} bash -c "cd ${DOKUWIKI_REPO_PATH} && git push --mirror ${EXTERNAL_REPO_URL}" >> "${LOG_FILE}" 2>&1

if [ $? -eq 0 ]; then
  echo "$(date): Sync successful." >> "${LOG_FILE}"
else
  echo "$(date): ERROR: Sync failed. Check SSH keys and repo URL." >> "${LOG_FILE}"
fi