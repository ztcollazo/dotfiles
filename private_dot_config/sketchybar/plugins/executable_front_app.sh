#!/bin/bash
APP=$(aerospace list-windows --focused --json | jq -r '.[0]."app-name"'
)
sketchybar --set $NAME label="$APP"
