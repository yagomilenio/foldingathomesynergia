#!/bin/bash

while true; do
  PAUSED=$(echo '{}' | ./websocat ws://127.0.0.1:7396/api/websocket \
    | jq -r '.groups[""].config.paused')

  if [ "$PAUSED" = "true" ]; then
    echo "Folding está en pausa"
    pkill fah-client
    break
  fi

  echo "Aún no está en pausa..."
  sleep 300
done
