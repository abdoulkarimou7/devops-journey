#!/bin/bash
set -euo pipefail

echo "=== Process Info ==="
total_processes=$(ps aux | wc -l)
echo "Total processes: $total_processes"
echo ""
echo "Top 5 memory-consuming processes:"
ps aux --sort=-%mem | head -6