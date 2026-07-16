#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

log_file="$1"

if [ ! -f "$log_file" ]; then
    echo "Error: File not found - $log_file"
    exit 1
fi

echo "=== Log Analyzer ==="
total_lines=$(wc -l < "$log_file")
echo "Total lines in log file: $total_lines"
echo ""
number_of_lines_with_error=$(grep -c "ERROR" "$log_file")
echo "Number of lines containing 'ERROR': $number_of_lines_with_error"
echo ""
echo "3 latest error lines:"
list_of_lines_with_error=$(grep "ERROR" "$log_file" | tail -3)
echo "$list_of_lines_with_error"