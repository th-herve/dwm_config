#!/usr/bin/env bash

firefox &
google-chrome &
spotify &
greenclip daemon &

# set up media keys
sxhkd -c ~/.config/sxhkd/sxhkdrc &

# set bg
feh --bg-scale ~/.dwm/cat_desk.png 




# Bar config
getDate(){
    currentDate="$(date +'%H:%M')"
    echo -e "$currentDate"
}

while true; do
    xsetroot -name " $(getDate)"
    sleep 1m
done &
