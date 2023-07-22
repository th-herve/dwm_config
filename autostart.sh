#!/usr/bin/env bash

firefox &

if command -v google-chrome &>/dev/null; then
  google-chrome &
else
  google-chrome-stable &
fi

# spotify &

greenclip daemon &

xmodmap ~/.Xmodmap
sxhkd -c ~/.config/sxhkd/sxhkdrc &

# make tab work as mod4 if hold
# ./script/tab_mod.sh

feh --bg-scale ~/.dwm/cat_desk.png 

getMute() {
# get [on] or [off] if mute or not
isMute=$(amixer get Master | grep Mono: | awk '{ print $NF }')
percent=$(amixer get Master | grep Mono: | awk '{ print $3 }')

if [ $isMute == "[off]" ] || [ $percent == "0" ]; then
    echo -e '󰝟'
fi
}

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
    xsetroot -name "$(getMute)   $(getBattery)    $(getDate)  "
    sleep 1s
done &
