#!/usr/bin/env bash

firefox &
google-chrome &
# spotify &
greenclip daemon &

# make tab work as mod4 if hold
# ./script/tab_mod.sh

feh --bg-scale ~/.dwm/cat_desk.png 

# Bar config
getDate(){
    currentDate="$(date +'%H:%M')"
    echo -e "$currentDate"
}

getBattery() {
    state="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{ print $2 }')"
    currentBattery="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{ print $2 }' | awk -F'%' '{print $1}')"

    if [ "$state" = "charging" ]; then
        if [ $currentBattery -gt 98 ]; then 
            echo -e "󰂅"
        elif [ $currentBattery -gt 90 ]; then
            echo -e "󰂋"
        elif [ $currentBattery -gt 70 ]; then
            echo -e "󰢞"
        elif [ $currentBattery -gt 60 ]; then
            echo -e "󰂉"
        elif [ $currentBattery -gt 50 ]; then
            echo -e "󰢝"
        elif [ $currentBattery -gt 40 ]; then
            echo -e "󰂈"
        elif [ $currentBattery -gt 30 ]; then
            echo -e "󰂇"
        elif [ $currentBattery -gt 20 ]; then
            echo -e "󰂆"
        else
            echo -e "󰢜"
        fi
        return
    fi

    
    if [ $currentBattery -gt 80 ]; then
        echo -e ""
    elif [ $currentBattery -gt 60 ]; then
        echo -e ""
    elif [ $currentBattery -gt 40 ]; then
        echo -e ""
    elif [ $currentBattery -gt 20 ]; then
        echo -e ""
    else
        echo -e ""
    fi
}


while true; do
    xsetroot -name "$(getBattery)    $(getDate)  "
    sleep 5s
done &
