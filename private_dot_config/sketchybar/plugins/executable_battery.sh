#!/bin/bash
PCT=$(pmset -g batt | rg '\d+%' | cut -d% -f1 | choose 2)
ICON=""
[ "$PCT" -lt 80 ] && ICON=""
[ "$PCT" -lt 60 ] && ICON=""
[ "$PCT" -lt 40 ] && ICON=""
[ "$PCT" -lt 20 ] && ICON=""
sketchybar --set $NAME label="$PCT%" icon="$ICON"
