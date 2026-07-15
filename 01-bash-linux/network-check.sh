#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage:./$0 <hostname>"
    exit 1
fi

hostname=$1
ping -c 2 "$hostname"

statusCode=$(curl -I ${hostname} 2>/dev/null | head -n 1 | awk '{print $2}')
echo "Status Code: $statusCode"
