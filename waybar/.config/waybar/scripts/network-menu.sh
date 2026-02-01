#!/bin/bash

# Ensure Wi-Fi is enabled
nmcli radio wifi on >/dev/null 2>&1

# Detect Wi-Fi interface automatically
iface=$(nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi"{print $1; exit}')

# Current connected SSID
current_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')

# List available networks
networks=$(nmcli -t -f IN-USE,SIGNAL,SECURITY,SSID dev wifi list |
  awk -F: '
    $4 != "" {
      inuse=($1=="*" ? "★" : " ")
      sig=$2"%"
      sec=($3=="" ? "Open" : $3)
      printf "%s %-4s %-8s %s\n", inuse, sig, sec, $4
    }' | sort -r)

choice=$(echo "$networks" | wofi \
  --dmenu \
  --prompt "Wi-Fi Networks" \
  --width 520 \
  --lines 10 \
  --location center)

[ -z "$choice" ] && exit 0

ssid=$(echo "$choice" | sed 's/^..*  //')

# Action menu
action=$(printf "Connect\nDisconnect\nForget" | wofi \
  --dmenu \
  --prompt "$ssid" \
  --width 300 \
  --location center)

case "$action" in
Connect)
  security=$(nmcli -t -f SECURITY dev wifi list | grep ":$ssid$" | cut -d: -f1)

  if [ -n "$security" ]; then
    password=$(wofi \
      --dmenu \
      --password \
      --prompt "Password for $ssid" \
      --width 400 \
      --location center)

    [ -z "$password" ] && exit 0

    nmcli dev wifi connect "$ssid" password "$password" ifname "$iface"
  else
    nmcli dev wifi connect "$ssid" ifname "$iface"
  fi
  ;;
Disconnect)
  [ "$ssid" = "$current_ssid" ] && nmcli dev disconnect "$iface"
  ;;
Forget)
  nmcli connection delete "$ssid" >/dev/null 2>&1
  ;;
esac
