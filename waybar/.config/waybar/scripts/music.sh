#!/bin/bash

showMusicStatusIcon() {
  local status
  status=$(playerctl status 2>/dev/null)

  case "$status" in
  Playing) echo "󰏤" ;; # pause icon
  Paused) echo "󰐊" ;;  # play icon
  *) echo "󰐊" ;;
  esac
}

openMusicSource() {
  player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

  # Hyprland uses 'class' or 'title' for dispatching focus
  if echo "$player" | grep -qi "chrome"; then
    hyprctl dispatch focuswindow '[app_id="chrome"]'
  elif echo "$player" | grep -qi "chromium"; then
    hyprctl dispatch focuswindow "chromium"
  else
    # Fallback: open YouTube Music in the default browser
    hyprctl dispatch exec xdg-open https://music.youtube.com
  fi
}

getMusicInfo() {
  local status artist title

  # Using playerctl to get metadata
  status=$(playerctl status 2>/dev/null) || return

  if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
    return
  fi

  artist=$(playerctl metadata xesam:artist 2>/dev/null)
  title=$(playerctl metadata xesam:title 2>/dev/null)

  # Limit string length for your height: 18 bar to prevent overflow
  info="${artist:-Unknown Artist} - ${title:-Unknown Title}"
  echo "${info:0:40}"
}

# -------- DISPATCH --------
case "$1" in
showMusicStatusIcon)
  showMusicStatusIcon
  ;;
openMusicSource)
  openMusicSource
  ;;
getMusicInfo)
  getMusicInfo
  ;;
*)
  echo "Usage: $0 {showMusicStatusIcon|openMusicSource|getMusicInfo}"
  exit 1
  ;;
esac
