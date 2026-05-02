# My Automation Scripts
This repository contains bash scripts I developed to automate server management tasks.

## Scripts Included:
1. **check_disk_usage.sh**: Monitors local disk usage and alerts if capacity exceeds 90%.
2. **check_server.sh**: Pings a target server (passed as an argument) and logs errors to `error_log.txt`.

## How to run:
Ensure files are executable:
`chmod +x *.sh`

Example:
`./check_server.sh google.com`
