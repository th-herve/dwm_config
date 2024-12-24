# Dwm config
## Installation

### Install dwm dependencies

Might work without it though (at least on arch).

```bash
# arch
sudo pacman -S base-devel libx11 libxft libxinerama freetype2 fontconfig

# debian
sudo apt install build-essential libx11-dev libxft-dev libxinerama-dev libfreetype6-dev libfontconfig1-dev

# fedora
sudo dnf install make gcc libXft-devel libX11-devel libXinerama-devel
```
## Install config dependencies

```bash
# Jet Brain nerd font
sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip && sudo unzip JetBrainsMono.zip -d /usr/share/fonts && rm -f JetBrainsMono.zip

# Others
sudo apt install feh flameshot dmenu sxhkd

# greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip && sudo mv greenclip /usr/local/bin/ 
# check if chmod +x is needed

# dmenu-bluetooth
wget "https://raw.githubusercontent.com/Layerex/dmenu-bluetooth/master/dmenu-bluetooth" && sudo install dmenu-bluetooth /usr/local/bin
```
### Clone the repo and build it

```bash
cd && git clone https://github.com/th-herve/dwm_config && mv dwm_config .dwm && cd .dwm && sudo ./make.sh
```

### Start dwm when x start

```bash
# copy the xinitrc in the home folder
cp /etc/X11/xinit/xinitrc ~/.xinitrc

# open the .xinitrc file delete everything except the first line and add:
dwm
```

run `startx` to launch dwm.

## Keybinds

### Dmenu/rofi script

- `Mod-d` -> Dmenu app laucher
- `Mod-z` -> Start menu
- `Mod-S-d` -> Rofi app laucher
- `Mod-v` -> greenclip menu
- `Mod-n` -> wifi menu
- `Mod-S-n` -> bluetooth menu

### Navigation and tag
 
- `Mod-[qwe123456]` -> navigate tag
- `Mod-S-[qwe123456]` -> move window to tag
- `Mod-C-[qwe123456]` -> add tag to the view
- `Mod-S-C-[qwe123456]` -> set window to several tag
- `Mod-0` -> see all tag
- `Mod-0` -> see all tag
- `Mod-j/k` -> navigate window
- `Mod-o/p` -> increase/decrease master windows
- `Mod-h/l` -> resize master/child windows
- `Mod-x` -> kill window
- `Mod-spc` -> toggle master/child
- `Mod-S-return` -> swap window between master/child
 
### Layouts

- `Mod-t` -> set tile layout
- `Mod-S-b` -> set floating layout
- `Mod-m` -> set monocle layout
- `Mod-r` -> set deck layout
- `Mod-S-spc` -> toggle floating window

## Others

- `Mod-return` -> open terminal
- `Mod-S-c` -> open gnome calculator
- `Mod-u/i` -> set us/international keyboard
- `Mod-b` -> toggle bar
