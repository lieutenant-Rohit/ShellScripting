#!/bin/bash
for site in $(cat server.txt)
do
  echo "Checking Status of $site"
  ping -c 1 $site >/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
	echo "$site is UP"
  else 
	echo "$site is Down"
  fi
done

