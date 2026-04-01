#!/bin/bash
SSID=$(ipconfig getsummary en0 | rg " SSID" | choose 2:)
[ -z "$SSID" ] && SSID="Offline"
sketchybar --set $NAME label="$SSID" icon=""
