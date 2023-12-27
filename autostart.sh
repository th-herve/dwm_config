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
feh --bg-scale ~/.dwm/wallpaper/forest_stairs.jpg

# Bar config
getTime(){
    currentDate="$(date +'%H:%M')"
    echo -e "$currentDate"
}

while true; do
    xsetroot -name " $(getTime)"
    sleep 1m
done &
