#!/bin/bash

set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Usage: $0 <config_file> <version>"
    exit 1
fi

config_file="$1"
version="$2"

if [ ! -f "$config_file" ]; then
    echo "Error: Config file not found - $config_file"
    exit 1
fi

old_version=$(awk -F= '/APP_VERSION/ {print $2}' | tr -d '[:space:]')
if [ -z "$old_version" ]; then
    echo "Error: Could not find the current version in the config file."
    exit 1
fi  

sed -i "s/^APP_VERSION=.*/APP_VERSION=$version/" "$config_file"

echo "Current version: $old_version -> New version: $version"



