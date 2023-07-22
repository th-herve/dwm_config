#!/usr/bin/env bash

xrandr -r 144

# set mouse setting
# get the mouse id
mouse_id=$(xinput | awk -F '=|\[' '/Logitech G Pro.*pointer/ { print $2}')

# Get the prop id for mouse acceleration
mouse_accel_id=$(xinput list-props $mouse_id | awk -F '\(|\)' '/.*Accel Profile Enabled \(.*/ { print $2}')

# remove mouse accel
xinput set-prop $mouse_id $mouse_accel_id 0, 1 
