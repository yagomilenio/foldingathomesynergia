#!/bin/bash

get_progress() {
  echo '{}' | ./websocat ws://127.0.0.1:7396/api/websocket \
    | jq -r '.groups[""].units[0].progress // "0"'
}

get_state() {
  echo '{}' | ./websocat ws://127.0.0.1:7396/api/websocket \
    | jq -r '.groups[""].units[0].state // "unknown"'
}

PROGRESS_BEFORE=$(get_progress)

while true; do
  STATE=$(get_state)

  if [ "$STATE" = "RUN" ]; then
    sleep 300
    PROGRESS_AFTER=$(get_progress)

    DECREASED=$(awk "BEGIN { print ($PROGRESS_AFTER < $PROGRESS_BEFORE) ? \"yes\" : \"no\" }")

    if [ "$DECREASED" = "yes" ]; then
      pkill fah-client
      break
    fi

    PROGRESS_BEFORE=$PROGRESS_AFTER 
  else
    sleep 30  
  fi
done
