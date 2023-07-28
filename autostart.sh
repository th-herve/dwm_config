#!/usr/bin/env bash

firefox &
# spotify &
greenclip daemon &
picom &

if command -v google-chrome &>/dev/null; then
  google-chrome &
else
  google-chrome-stable &
fi



# keyboard setting 
xmodmap ~/.Xmodmap
sxhkd -c ~/.config/sxhkd/sxhkdrc &
/bin/bash ~/.dwm/script/tab_mod4.sh

feh --bg-scale ~/.dwm/cat_desk.png 

# Bar config
getMute() {
    # get [on] or [off] if mute or not
    isMute=$(amixer get Master | grep Mono: | awk '{ print $NF }')
    percent=$(amixer get Master | grep Mono: | awk '{ print $3 }')

    if [ $isMute == "[off]" ] || [ $percent == "0" ]; then
        echo  "󰝟"
    else 
        echo " "
    fi
}

getDate(){
    currentDate="$(date +'%H:%M')"
    echo  "$currentDate"
}

getBattery() {
    state="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{ print $2 }')"
    currentBattery="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{ print $2 }' | awk -F'%' '{print $1}')"

    if [ "$state" = "charging" ]; then
        if [ $currentBattery -gt 98 ]; then 
            echo  "󰂅"
        elif [ $currentBattery -gt 90 ]; then
            echo  "󰂋"
        elif [ $currentBattery -gt 70 ]; then
            echo  "󰢞"
        elif [ $currentBattery -gt 60 ]; then
            echo  "󰂉"
        elif [ $currentBattery -gt 50 ]; then
            echo  "󰢝"
        elif [ $currentBattery -gt 40 ]; then
            echo  "󰂈"
        elif [ $currentBattery -gt 30 ]; then
            echo  "󰂇"
        elif [ $currentBattery -gt 20 ]; then
            echo  "󰂆"
        else
            echo  "󰢜"
        fi
        return
    fi

    
    if [ $currentBattery -gt 80 ]; then
        echo  ""
    elif [ $currentBattery -gt 60 ]; then
        echo  ""
    elif [ $currentBattery -gt 40 ]; then
        echo  ""
    elif [ $currentBattery -gt 20 ]; then
        echo  ""
    else
        echo  ""
    fi
}

while true; do
    xsetroot -name "$(getMute)   $(getBattery)    $(getDate)  "
    sleep 1s
done &
