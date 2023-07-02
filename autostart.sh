#!/usr/bin/env bash

firefox &
google-chrome &
spotify &

# Bar config

getDate(){
    currentDate="$(date +'%H:%M')"
    echo -e " $currentDate"
}

while true; do
    xsetroot -name "$(getDate)"
    sleep 1m
done &
