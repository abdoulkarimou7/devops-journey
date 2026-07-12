#!/bin/bash
set -ueo pipefail

#checking if there is an argument passed to the script
if [ $# -eq 0 ]; then
    echo "No arguments provided. Please provide a limite of disk space in percentage."
    exit 1
fi

echo "=== Disk Space Check ==="
echo "Date: $(date)"
echo ""
echo "=== Disk usage ==="

# Getting the / disk usage percentage for the provided path and removing the '%' sign
SEUIL=$1
USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
echo "Usage disque actuel : ${USAGE}%"
echo "Disk usage for $1: ${SEUIL}%" 

# compare the disk usage with the threshold
if [ "$USAGE" -gt "$SEUIL" ]; then
    echo "Disk usage is above the threshold of ${SEUIL}%. Please take action."
    exit 1
else
    echo "Disk usage is below the threshold of ${SEUIL}%. All good."
    exit 0
fi