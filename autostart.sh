#!/usr/bin/env bash

firefox &
google-chrome &
spotify &
greenclip daemon &

# Bar config
getDate(){
    currentDate="$(date +'%H:%M')"
    echo -e "$currentDate"
}

# set bg
feh --bg-scale ~/.dwm/cat_desk.png 

while true; do
    xsetroot -name " $(getDate)"
    sleep 1m
done &
