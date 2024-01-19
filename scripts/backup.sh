#!/bin/bash

# Timestamp for the backup file

# Backup filename
BACKUP_FILE="/backup/db_backup.sql"

# Perform the backup

export PGPASSWORD=$POSTGRES_PASSWORD
pg_dump -U "${POSTGRES_USER}" -h db -d "${POSTGRES_DB}" > "${BACKUP_FILE}"

# Check if the backup was successful
if [ -f "${BACKUP_FILE}" ]; then
    echo "Backup successful, uploading to Google Cloud Storage..."

    # Upload to Google Cloud
    ~/gcloud/google-cloud-sdk/bin/gsutil cp "${BACKUP_FILE}" gs://meliad_eu2/backups/db_backup.sql

    echo "Upload complete. Cleaning up local backup file..."
    # Clean up local backup file
else
    echo "Backup failed. Backup file not created."
    exit 1
fi
