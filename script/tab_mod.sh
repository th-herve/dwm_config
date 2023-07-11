#!/usr/bin/env bash

mod4="Super_L"

xmodmap -e "keycode 23  = $mod4"
# xmodmap -e "remove mod4 = $mod4"
# xmodmap -e "add Control = $mod4"

xmodmap -e "keycode 217 = Tab"

xcape -e "$mod4=Tab"
