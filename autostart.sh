#!/usr/bin/env bash

firefox &
google-chrome &
spotify &
# greenclip daemon &

# Bar config
getDate(){
    currentDate="$(date +'%H:%M')"
    echo -e "$currentDate"
}

getBattery() {
    currentBattery="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{ print $2 }')"
    echo -e "$currentBattery"
}


while true; do
    xsetroot -name " $(getDate) $(getBattery)"
    sleep 1s
done &
