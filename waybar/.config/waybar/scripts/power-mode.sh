#!/bin/bash

getPowerMode() {
  powerprofilesctl get 2>/dev/null
}

showPowerModePanel() {
  local choice
  choice=$(printf "Power Saver\nBalanced\nPerformance" | wofi --dmenu)

  case "$choice" in
  "Power Saver") powerprofilesctl set power-saver ;;
  "Balanced") powerprofilesctl set balanced ;;
  "Performance") powerprofilesctl set performance ;;
  esac
}

# -------- DISPATCH --------
case "$1" in
getPowerMode)
  getPowerMode
  ;;
showPowerModePanel)
  showPowerModePanel
  ;;
*)
  echo "Usage: $0 {getPowerMode|showPowerModePanel}"
  exit 1
  ;;
esac
