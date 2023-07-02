#!/usr/bin/env bash

firefox &
google-chrome &
spotify &

while true; do
    xsetroot -name "$(date +'%H:%M')"
    sleep 1m
done &
