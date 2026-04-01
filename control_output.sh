#!/bin/bash

WU_ID=""

while True; do

    NEW_ID=`echo '{}' | sh ./websocat ws://127.0.0.1:7396/api/websocket | jq -r '.units[0].id'`

    if [ -z "$NEW_ID" ]; then
        sleep 10
        continue
    fi

    if [ -z "$WU_ID" ]; then
        WU_ID="$NEW_ID"
        echo "WU detectada: $WU_ID"
    elif [ "$NEW_ID" != "$WU_ID" ]; then
        echo "WU cambió: $WU_ID -> $NEW_ID"
        pkill fah-client
        break
    fi

    sleep 30
done
