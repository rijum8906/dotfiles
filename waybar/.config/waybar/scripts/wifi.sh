#!/bin/bash

# --- YOUR FUNCTIONS ---
getPowerStatus() { nmcli radio wifi; }
turnON() { nmcli radio wifi on; }
turnOFF() { nmcli radio wifi off; }

scanDevices() {
  WIFI_JSON=$(nmcli -t -f IN-USE,SSID,BARS,SECURITY dev wifi list | grep -v "^:" |
    jq -R -s '
      split("\n")
      | map(select(length > 0))
      | map(split(":"))
      | map({
          in_use: (.[0] == "*"),
          ssid: .[1],
          bars: .[2],
          security: (if .[3] == "" or .[3] == "--" then "Open" else .[3] end)
        })
    ')
}

# --- MAIN LOGIC ---
status=$(getPowerStatus)

if [ "$status" = "disabled" ]; then
  options="󰂰 Turn ON WiFi"
else
  # Format the list for Wofi: SSID | Signal | Security
  raw_list=$(scanDevices)
  # Replace colons with spaces for a cleaner look in the menu
  formatted_list=$(echo "$raw_list" | awk -F: '{print $1 "  [" $2 "]  " $3}')
  options="󰂲 Turn OFF WiFi\n$formatted_list"
fi

# --- WOFI WINDOW ---
# Using dmenu mode to capture the selection
chosen=$(echo -e "$options" | wofi --dmenu --prompt "Networks ($status)" --width 450 --height 350)

# --- ACTION HANDLER ---
if [[ "$chosen" == *"Turn ON WiFi"* ]]; then
  turnON
elif [[ "$chosen" == *"Turn OFF WiFi"* ]]; then
  turnOFF
elif [ -n "$chosen" ]; then
  # Extract SSID (it's the first part of our formatted string)
  ssid=$(echo "$chosen" | awk '{print $1}')

  # Check if security is needed (looking back at our raw list for this SSID)
  security=$(echo "$raw_list" | grep "^$ssid:" | cut -d: -f3)

  if [[ -n "$security" && "$security" != "--" ]]; then
    # Ask for password via Wofi
    pass=$(wofi --dmenu --prompt "Password for $ssid" --password)
    if [ -n "$pass" ]; then
      nmcli dev wifi connect "$ssid" password "$pass"
    fi
  else
    nmcli dev wifi connect "$ssid"
  fi
fi
