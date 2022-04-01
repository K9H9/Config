#!/bin/sh
MESSAGE="What do you want to do "${USER^}"?"
POWER=""
RESTART=""
LOGOUT=""
LOCK=""
RES=`echo "$POWER|$RESTART|$LOGOUT|$LOCK" | rofi -dmenu -p " " -sep "|" -theme powermenu -monitor -1`
[ "$RES" = "$POWER" ] && sudo openrc-shutdown -p now
[ "$RES" = "$RESTART" ] && reboot
[ "$RES" = "$LOGOUT" ] && pkill init
[ "$RES" = "$LOCK" ] && echo "en sammuta" 
