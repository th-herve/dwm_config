# Dwm config
## Installation

### Install dwm dependencies
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
sudo apt install feh flameshot dmenu sxhkd greenclip
```
### Clone the repo and build it

```bash
cd && git clone https://github.com/th-herve/dwm_config && mv dwm_config .dwm && cd .dwm && sudo ./make.sh
```
