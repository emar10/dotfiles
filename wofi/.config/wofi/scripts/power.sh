#!/bin/sh

OPTS="Logout\nSuspend\nReboot\nShutdown"

selection=$(echo -e $OPTS | wofi -i --dmenu)

case $selection in 
    Logout)
        swaymsg exit;;
    Suspend)
        systemctl suspend;;
    Reboot)
        systemctl reboot;;
    Shutdown)
        systemctl poweroff;;
esac
