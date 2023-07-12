#!/usr/bin/env bash

xmodmap ~/.Xmodmap

mod4="Super_L"
xmodmap -e "keycode 23  = $mod4"

xmodmap -e "keycode 217 = Tab"

xcape -e "$mod4=Tab"
