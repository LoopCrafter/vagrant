#!/bin/bash

THRESHOLD=90
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ $DISK_USAGE -gt $THRESHOLD ]; then
  MESSAGE="Disk usage is above threshold: ${DISK_USAGE}%"
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE"
fi
