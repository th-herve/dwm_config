#!/usr/bin/env bash

firefox &
google-chrome &
spotify-launcher &
greenclip daemon &

picom &
dunst &

# set up media keys
sxhkd -c ~/.config/sxhkd/sxhkdrc &

# set bg
feh --bg-scale ~/.dwm/wallpaper/leaves2.png

# Bar config
getTime(){
    currentDate="$(date +'%H:%M')"
    echo -e "$currentDate"
}

getKb(){
    isIntl=$(setxkbmap -print | grep intl)
    if [[ -n "$isIntl" ]]; then
        echo -e ""
    else
        echo ""
    fi
}

while true; do
    xsetroot -name "$(getKb)  $(getTime)"
    sleep 1s
done &
