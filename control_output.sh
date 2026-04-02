#!/bin/bash

while true; do

    STATE=$(echo '{}' | ./websocat ws://127.0.0.1:7396/api/websocket)
    
    NEW_ID=$(echo "$STATE" | jq -r '.units[0].id // empty')
    PROGRESS=$(echo "$STATE" | jq -r '.units[0].wu_progress // 0')
    ETA=$(echo "$STATE" | jq -r '.units[0].eta // empty')

    if [ -z "$NEW_ID" ] || [ "$NEW_ID" = "null" ]; then
        sleep 10
        continue
    fi


    SLEEP_SECS=0
    DAYS=$(echo "$ETA"    | grep -oP '\d+(?=d)' || echo 0)
    HOURS=$(echo "$ETA"   | grep -oP '\d+(?=h)' || echo 0)
    MINUTES=$(echo "$ETA" | grep -oP '\d+(?=m)' || echo 0)

    SLEEP_SECS=$(( ${DAYS:-0}*86400 + ${HOURS:-0}*3600 + ${MINUTES:-0}*60 ))

    if [ "$SLEEP_SECS" -gt 0 ]; then
        sleep "$SLEEP_SECS"
    fi


    while true; do
        STATE=$(echo '{}' | ./websocat ws://127.0.0.1:7396/api/websocket)
        NEW_PROGRESS=$(echo "$STATE" | jq -r '.units[0].wu_progress // 0')

        
        if [ "$(echo "$NEW_PROGRESS < $PROGRESS" | bc -l)" = "1" ]; then
            sleep 300
            pkill fah-client
            exit 0
        fi

        PROGRESS=$NEW_PROGRESS
        sleep 300
    done

done
