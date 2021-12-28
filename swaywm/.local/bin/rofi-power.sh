#!/bin/bash

# Rofi Power Menu
# Author: Ethan Martin
# Date: 27 December 2021
#
# A power menu script to be run by rofi.
# ex: rofi -show powermenu -modi powermenu:rofi-power.sh

declare -A options
options=(
    ["logout"]="Logout"
    ["suspend"]="Suspend"
    ["restart"]="Restart"
    ["shutdown"]="Shut Down"
)

declare -A commands
commands=(
    ["logout"]="swaymsg exit"
    ["suspend"]="systemctl suspend"
    ["restart"]="systemctl reboot"
    ["shutdown"]="systemctl poweroff"
)

if [[ $# -eq 0 ]]; then
    # Print options and exit
    for option in "${options[@]}"; do
        echo $option
    done
else
    # Validate and run command for option
    for option in ${!options[@]}; do
        if [[ "$@" = "${options[$option]}" ]]; then
            ${commands[$option]}
        fi
    done
fi
