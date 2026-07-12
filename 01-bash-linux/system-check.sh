#!/bin/bash

echo "=== System Check ==="
echo "Date: $(date)"
echo ""
echo "=== Disk usage ==="
df -h
echo ""
echo "=== Memory ==="
free -h
echo ""
echo "=== User ==="
whoami
