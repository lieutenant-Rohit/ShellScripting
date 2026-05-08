#!/bin/bash

# 1. ANCHOR: Set the "home base" for Crontab
cd /Users/root1/Desktop/ShellScripting

# 2. PREP: Ensure the logs folder exists
mkdir -p logs

# 3. TASK 2: LOG ROTATION (The Janitor)
# If status.log is > 10KB, move it to .old and start fresh
if [[ -f "logs/status.log" ]] && [[ $(stat -f%z "logs/status.log") -gt 10000 ]]; then
    mv logs/status.log logs/status.log.old
    touch logs/status.log
    echo "$(date "+%Y-%m-%d %H:%M:%S") - NOTICE: Log rotated (limit 10KB reached)" >> logs/status.log
fi

# 4. INITIALIZE COUNTERS (Task 1)
TOTAL=0
SUCCESS=0

# 5. EXECUTION LOOP
for site in $(cat server.txt)
do
    ((TOTAL++))
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    # The -IsL flags make curl fast and quiet
    /usr/bin/curl -IsL --max-time 3 "$site" >/dev/null 2>&1

    if [[ $? -eq 0 ]]; then
        echo "$TIMESTAMP - $site is UP" >> logs/status.log
        ((SUCCESS++))
    else
        echo "$TIMESTAMP - $site is DOWN" >> logs/status.log
        # --- ALARM 1: Server Alert (Fixed Syntax) ---
        osascript -e "display notification \"$site is DOWN!\" with title \"Server Alert\""
    fi
done

# 6. SUMMARY (Task 1)
echo "--- SUMMARY: $SUCCESS/$TOTAL servers online ---" >> logs/status.log

# 7. TASK 3: DISK HEALTH (Using your 'tr' improvement)
# Checks if the disk usage number is greater than 90
USAGE=$(df -h / | grep "/" | awk '{print $5}' | tr -d '%')

if [ "$USAGE" -gt 90 ]; then
    echo "$(date "+%Y-%m-%d %H:%M:%S") - ALERT: Disk Usage is CRITICAL at ${USAGE}%!" >> logs/status.log
    # --- ALARM 2: Disk Alert (Fixed Syntax) ---
    osascript -e "display notification \"Disk is ${USAGE}% full!\" with title \"Storage Alert\""
fi

echo "------------------------------------------------" >> logs/status.log
