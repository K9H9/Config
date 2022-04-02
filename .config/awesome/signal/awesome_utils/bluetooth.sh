#!/bin/sh

state="$(bluetoothctl show | egrep "Powered" | cut -d " " -f 2)"
connection=$(bluetoothctl info | egrep "Connected" | cut -d " " -f 2)
dev="$(bluetoothctl info | egrep "Name" | cut -d " " -f 2)"

if [[ $state == "yes" ]]; then
    if  [[ $connection == "yes" ]]; then
        echo "Connected to $dev"
    else
        echo "Not Connected"
    fi
else
    echo "Bluetooth off"
fi