#!/bin/bash

SERVICES=$(systemctl list-units --type=service --state=active | awk '{print $1}' | grep -v '\.service')

for SERVICE in $SERVICES
do
  systemctl is-active --quiet $SERVICE

  if [ $? -ne 0 ]; then
    echo "$SERVICE is not running. Restarting..."
    systemctl restart $SERVICE
    echo "$SERVICE was restarted" | mail -s "$SERVICE Service Restarted" your-email@example.com
  else
    echo "$SERVICE is running"
  fi
done