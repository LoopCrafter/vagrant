#!/bin/bash

TOKEN="###"
CHAT_ID="###"
LOG_FILE="/var/log/auth.log"
FAILED_LOGINS=$(grep "Failed password" $LOG_FILE)


if [ ! -z "$FAILED_LOGINS" ]; then
  MESSAGE="Failed login attempts detected:\n$FAILED_LOGINS"
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE"
fi