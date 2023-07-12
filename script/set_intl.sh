#!/usr/bin/env bash

setxkbmap us -variant intl

# set tab hold as mod4
mod4="Super_L"
xmodmap -e "keycode 23  = $mod4"
xmodmap -e "keycode 217 = Tab"
xcape -e "$mod4=Tab"
