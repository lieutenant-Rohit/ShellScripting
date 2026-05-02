#!/bin/bash

TARGET=$1
echo "Checking Connection to $TARGET"

ping -c 1 $TARGET > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
   echo "SERVER IS UP"
   echo -n "Server IP:"
   ping -c 1 $TARGET | grep "PING" | awk '{print $3}' | tr -d '()'
else
   echo "SERVER IS DOWN"
   echo "$(date): $TARGET was unreachable" > error_log.txt
fi
