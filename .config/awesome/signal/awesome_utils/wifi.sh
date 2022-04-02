#!/bin/sh

operstate="$(cat /sys/class/net/wlan0/operstate)"
wifiid="$(iwgetid -r)"
if [ "$operstate" != "up" ]; then 
    echo "Not connected"
else
    echo "Connected to $wifiid"
fi