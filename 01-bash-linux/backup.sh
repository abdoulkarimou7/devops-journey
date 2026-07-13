#! /bin/bash

set -ueo pipefail
 if [ $# -eq 0 ]; then
    echo "Give the directory path or name to backup as an argument."
    exit 1
fi
date=$(date +%Y-%m-%d)
tar -czf "backup_zip_file_${date}_archive.tar.gz" "$1"
 if [ $? -eq 0 ]; then
    echo "Backup successful."
    echo "Backup file created: backup_zip_file_${date}_archive.tar.gz"
else
    echo "Backup failed."
    exit 1
fi 
