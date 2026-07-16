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

### `env-check.sh`
This script show variable of environnements : User, path, shell,home and current directory.


**Usage:**
\`\`\`bash
./env-check.sh
\`\`\`

**Example:**
\`\`\`bash
./env-check.sh
\`\`\`

### `log-analyzer.sh`
this script show some detaille about your log (<log_file>) : number of lines, number of lines with error and 3 latest error lines.


**Usage:**
\`\`\`bash
./log-analyzer.sh <log_file>
\`\`\`

**Example:**
\`\`\`bash
./log-analyzer.sh test.log
\`\`\

### `network-check.sh`
Tests connectivity via ping and displays the HTTP status code of the host.


**Usage:**
\`\`\`bash
./network-check.sh <hostname>
\`\`\`

**Example:**
\`\`\`bash
./network-check.sh google.com
\`\`\

### `process-info.sh`
this script show the number of process and top 5 memory-consuming processes.


**Usage:**
\`\`\`bash
./process-info.sh
\`\`\`

**Example:**
\`\`\`bash
./process-info.sh
\`\`\

### `bump-version.sh`
Update version in the configue file with sed.


**Usage:**
\`\`\`bash
./bump-version.sh <config_file> <version>
\`\`\`

**Example:**
\`\`\`bash
./bump-version.sh config.env 1.0.1
\`\`\