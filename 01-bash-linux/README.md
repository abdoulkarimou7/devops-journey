# 01-bash-linux

Practice scripts covering Bash fundamentals: system diagnostics, disk monitoring, and backup automation.

## Scripts

### `system-check.sh`
Displays basic system status: current date, disk usage, memory usage, and current user.

**Usage:**
\`\`\`bash
./system-check.sh
\`\`\`

**Example:**
\`\`\`bash
./system-check.sh
\`\`\`

### `check-disk-space.sh`
Checks the disk usage of the root filesystem (`/`) against a given threshold. Exits with an alert (exit code 1) if usage exceeds the threshold, or confirms it's within limits (exit code 0) otherwise.

**Usage:**
\`\`\`bash
./check-disk-space.sh <threshold_percentage>
\`\`\`

**Example:**
\`\`\`bash
./check-disk-space.sh 80
\`\`\`

### `backup.sh`
Creates a compressed `.tar.gz` archive of a given directory, with the current date included in the filename.

**Usage:**
\`\`\`bash
./backup.sh <directory_path>
\`\`\`

**Example:**
\`\`\`bash
./backup.sh 01-bash-linux
\`\`\`