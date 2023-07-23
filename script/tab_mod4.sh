#!/usr/bin/env bash

spare_modifier="Hyper_L"

xmodmap -e "keycode 23 = $spare_modifier"
# xmodmap -e "remove mod1 = $spare_modifier"
# xmodmap -e "add mod4 = $spare_modifier"
xmodmap -e "keycode 8 = Tab"

xcape -e "$spare_modifier=Tab"
