#!/usr/bin/env bash

rm -rf ./config.h

make install

desktop=/usr/share/xsessions/dwm.desktop

if [ ! -f "$desktop" ]; then
    echo "[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=/usr/local/bin/dwm
Icon=dwm
Type=XSession" > $desktop
fi
