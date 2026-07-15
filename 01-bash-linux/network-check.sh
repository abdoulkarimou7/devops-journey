#!/bin/bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage:./$0 <hostname>"
    exit 1
fi

hostname=$1
if ping -c 2 "$hostname" 2>/dev/null; then
    echo "Ping successful"
else
    echo "Ping failed or blocked (this doesn't always mean the host is down)"
fi

echo ""
echo "=== HTTP status ==="
statusCode=$(curl -IL "https://$hostname" 2>/dev/null | grep "HTTP" | tail -1 | awk '{print $2}')
if [ -z "$statusCode" ]; then
    echo "Could not reach $hostname via HTTP"
else
    echo "Status Code: $statusCode"
fi