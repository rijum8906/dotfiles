#!/bin/sh

# folders to search
DIRS="$HOME/Pictures/wallpapers"

# find images
IMG="$(find $DIRS -type f \( \
  -iname '*.jpg' -o \
  -iname '*.jpeg' -o \
  -iname '*.png' -o \
  -iname '*.webp' \
  \) 2>/dev/null | shuf -n 1)"

# exit quietly if nothing found
[ -z "$IMG" ] && exit 0

# give daemon a moment
sleep 0.5

# set wallpaper
swww img "$IMG" \
  --transition-type fade \
  --transition-duration 1
