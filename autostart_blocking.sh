#!/usr/bin/env bash

# set taping the pad as click
pad_id=$(xinput | awk -F '=|\\[' '/Synaptics/ { print $2}')

# Get the prop id for pad tap
tap_id=$(xinput list-props $pad_id | awk -F '\\(|\\)' '/.*Tapping Enabled \(.*/ { print $2}')

xinput set-prop $pad_id $tap_id 1
