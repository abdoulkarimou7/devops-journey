#!/bin/bash
set -euo pipefail

SEUIL="${1:-80}"
NumberOfAlerts=0
LOGFILE="health-check.log"

log() {
    local message="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "$message"
    echo "$message" >> "$LOGFILE"
}

check_disk() {
    local usage
    usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    if [ "$usage" -gt "$SEUIL" ]; then
        log "ALERT: Disk usage (${usage}%) exceeds threshold (${SEUIL}%)"
        NumberOfAlerts=$((NumberOfAlerts + 1))
    else
        log "OK: Disk usage (${usage}%) is within threshold (${SEUIL}%)"
    fi
}

check_memory() {
    local mem_available
    mem_available=$(free -m | awk 'NR==2 {print $7}')
    if [ "$mem_available" -lt 500 ]; then
        log "ALERT: Available memory (${mem_available}MB) is below 500MB"
        NumberOfAlerts=$((NumberOfAlerts + 1))
    else
        log "OK: Available memory (${mem_available}MB) is above 500MB"
    fi
}

echo "=== Health Check Started ==="
check_disk
check_memory
echo "=== Health Check Completed ==="
echo "Total alerts: $NumberOfAlerts"