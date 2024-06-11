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

if tmux ls; then
    kitty sh -c 'tmux a; exec zsh' &
else
    kitty sh -c 'tmux; exec zsh' &
fi

# keyboard setting 
xmodmap ~/.Xmodmap
sxhkd -c ~/.config/sxhkd/sxhkdrc &
/bin/bash ~/.dwm/script/tab_mod4.sh

feh --bg-scale ~/.dwm/cat_desk.png 

# Bar config
getMute() {
    # get [on] or [off] if mute or not
    isMute=$(amixer get Master | grep Left | awk '{ print $NF }')
    percent=$(amixer get Master | grep Left | awk '{ print $3 }')

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
            echo  "$currentBattery 󰂅"
        elif [ $currentBattery -gt 90 ]; then
            echo  "$currentBattery 󰂋"
        elif [ $currentBattery -gt 70 ]; then
            echo  "$currentBattery 󰢞"
        elif [ $currentBattery -gt 60 ]; then
            echo  "$currentBattery 󰂉"
        elif [ $currentBattery -gt 50 ]; then
            echo  "$currentBattery 󰢝"
        elif [ $currentBattery -gt 40 ]; then
            echo  "$currentBattery 󰂈"
        elif [ $currentBattery -gt 30 ]; then
            echo  "$currentBattery 󰂇"
        elif [ $currentBattery -gt 20 ]; then
            echo  "$currentBattery 󰂆"
        else
            echo  "$currentBattery 󰢜"
        fi
        return
    fi

    
    if [ $currentBattery -gt 80 ]; then
        echo  "$currentBattery "
    elif [ $currentBattery -gt 60 ]; then
        echo  "$currentBattery "
    elif [ $currentBattery -gt 40 ]; then
        echo  "$currentBattery "
    elif [ $currentBattery -gt 20 ]; then
        echo  "$currentBattery "
    else
        echo  "$currentBattery "
    fi
}

while true; do
    xsetroot -name " $(getBattery)    $(getDate)  "
    sleep 1s
done &
