#!/bin/bash

if [[ ! -f "server.txt" ]]; then
    echo "ERROR: server.txt not found!"
    exit 1
fi

mkdir -p logs

echo "Starting connectivity check..."
echo "-----------------------------"

for site in $(cat server.txt)
do
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

  curl -IsL --max-time 3 "$site" >/dev/null 2>&1

  if [[ $? -eq 0 ]]; then
        echo "$site is UP"
  else
        echo "$site is DOWN"
        echo "$TIMESTAMP - $site is DOWN" >> logs/status.log
  fi
done

echo "-----------------------------"
echo "Check complete. Logs saved to logs/status.log"
