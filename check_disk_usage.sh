#!/bin/bash
USAGE=$(df -h | grep "/$" | awk '{print $5}' | tr -d '%')

if [[ "$USAGE" -ge 90 ]]; then
   echo "ALERT: DISK IS AT $USAGE%"
else
   echo "DISK IS HEALTHY AT $USAGE%"
fi
