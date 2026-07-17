#!/bin/bash

set -euo pipefail


SEUIL=80
memory=500
log_file="server-toolkit.log"
Number_of_alerte=0

function log() {
local message="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "$message"
    echo "$message" >> "$log_file"
}

function help() {
    echo "Usage: $0 [-d threshold] [-m memory] [-l log_file] [-h help]"
    echo "  -d threshold : Set the disk usage threshold (default: 80)"
    echo "  -m memory    : Set the memory limit in MB (default: 500)"
    echo "  -l log_file  : Set the log file name (default: server-toolkit.log)"
    echo "  -h           : Display this help message"
}

while getopts "d:m:l:h" option; do
	case $option in 
	d) if [[ $OPTARG =~ ^[0-9]+$ ]]; then SEUIL="$OPTARG"; else echo "Invalid threshold value"; help; exit 1; fi;;
	m) if [[ $OPTARG =~ ^[0-9]+$ ]]; then memory="$OPTARG"; else echo "Invalid memory value"; help; exit 1; fi;;
	l) if [[ $OPTARG =~ ^[0-9]+$ ]]; then echo "Invalid log file name"; help; exit 1; else log_file="$OPTARG"; fi;;
	h) help
	exit 0;;
	esac
done
