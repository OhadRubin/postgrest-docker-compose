#!/bin/bash

# Backup script location
BACKUP_SCRIPT="/scripts/backup.sh"

# Add a cron job to the crontab that runs the backup script at scheduled times
echo "0 3 * * * /bin/bash $BACKUP_SCRIPT" > crontab.txt

# Load the crontab
crontab crontab.txt

# Start the cron daemon in the foreground
cron -f
