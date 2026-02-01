#!/bin/bash

showMusicStatusIcon() {
  local status
  status=$(playerctl status 2>/dev/null)

  case "$status" in
  Playing) echo "󰏤" ;; # pause
  Paused) echo "󰐊" ;;  # play
  *) echo "󰐊" ;;
  esac
}

openMusicSource() {
  player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

  if echo "$player" | grep -qi chrome; then
    swaymsg '[app_id="chrome"] focus'
  elif echo "$player" | grep -qi chromium; then
    swaymsg '[app_id="chrome"] focus'
  else
    # fallback: open YouTube Music or Spotify Web
    swaymsg exec xdg-open https://music.youtube.com
  fi
}

getMusicInfo() {
  local status artist title

  status=$(playerctl --player=plasma-browser-integration status 2>/dev/null) || return

  if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
    return
  fi

  artist=$(playerctl --player=plasma-browser-integration metadata xesam:artist 2>/dev/null)
  title=$(playerctl --player=plasma-browser-integration metadata xesam:title 2>/dev/null)

  echo "${artist:-Unknown Artist} - ${title:-Unknown Title}"
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
  echo "Unknown command"
  exit 1
  ;;
esac
