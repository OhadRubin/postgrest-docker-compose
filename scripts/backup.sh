#!/bin/bash

# Timestamp for the backup file
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Backup filename
BACKUP_FILE="/backup/db_backup_${TIMESTAMP}.sql"

# Perform the backup
pg_dump -U "${POSTGRES_USER}" -h db -d "${POSTGRES_DB}" > "${BACKUP_FILE}"

# Check if the backup was successful
if [ -f "${BACKUP_FILE}" ]; then
    echo "Backup successful, uploading to Google Cloud Storage..."

    # Upload to Google Cloud
    gsutil cp "${BACKUP_FILE}" gs://[YOUR_BUCKET_NAME]/path/to/backup/

    echo "Upload complete. Cleaning up local backup file..."
    # Clean up local backup file
    rm "${BACKUP_FILE}"
else
    echo "Backup failed. Backup file not created."
    exit 1
fi