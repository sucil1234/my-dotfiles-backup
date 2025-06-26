#!/bin/bash

# Define the options for Wofi
entries="Lock\nLogout\nReboot\nShutdown"

# Show Wofi with the options
selected=$(echo -e $entries | wofi --dmenu --prompt "Power Menu" --width 250 --height 210)

# Execute a command based on the selected option
case $selected in
  "Lock")
    hyprctl dispatch exec hyprlock
    ;;
  "Logout")
    hyprctl dispatch exit
    ;;
  "Reboot")
    systemctl reboot
    ;;
  "Shutdown")
    systemctl poweroff
    ;;
esac
