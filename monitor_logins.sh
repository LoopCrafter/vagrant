#!/bin/bash

TOKEN="123456:ABC-DEF"
CHAT_ID="-100123456789"
LOG_FILE="/var/log/auth.log"

tail -f $LOG_FILE | grep --line-buffered "Failed password" | while read line; do
    MESSAGE="Failed login attempt detected! Details: $line"
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$MESSAGE"
done