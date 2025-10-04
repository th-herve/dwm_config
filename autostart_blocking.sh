#!/usr/bin/env bash

xrandr -r 240

# set mouse setting
# get the mouse id
mouse_id=$(xinput | awk -F '=|\\[' '/Logitech G Pro.*pointer/ { print $2}')

# Get the prop id for mouse acceleration
mouse_accel_id=$(xinput list-props $mouse_id | awk -F '\\(|\\)' '/.*Accel Profile Enabled \(.*/ { print $2}')

mouse_speed_id=$(xinput list-props $mouse_id | awk -F '\\(|\\)' '/.*Accel Speed \(.*/ { print $2}')

# remove mouse accel
xinput set-prop $mouse_id $mouse_accel_id 0, 0, 0
xinput set-prop $mouse_id $mouse_speed_id -0.5

# set up thumb wheel of mx master 3s
mx_id=$(xinput | awk -F '=|\\[' '/Logitech USB Receiver Mouse/ { print $2}')

xinput set-button-map $mx_id 1 2 3 4 5 4 5 8 9 10 11 12 13 14 15 16 17 18 19 20 
