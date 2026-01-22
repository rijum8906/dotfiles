#!/bin/bash

BT=$(bluetoothctl info 2>/dev/null)

if [[ -z "$BT" ]]; then
  echo '{"text":"󰂲","tooltip":"Bluetooth off"}'
  exit 0
fi

NAME=$(echo "$BT" | grep "Name:" | cut -d' ' -f2-)
BATT=$(echo "$BT" | grep "Battery Percentage" | awk '{print $3}')

if [[ -z "$NAME" ]]; then
  echo '{"text":"󰂲","tooltip":"No device connected"}'
else
  if [[ -z "$BATT" ]]; then
    echo "{\"text\":\"󰂯 $NAME\",\"tooltip\":\"Connected\"}"
  else
    echo "{\"text\":\"󰂯 $NAME $BATT%\",\"tooltip\":\"Battery: $BATT%\"}"
  fi
fi
