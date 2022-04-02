### My Configuration files - Work in progress
- [General Info](#general-info)
- [My Setup](#my-setup)
- [Dependencies](#dependencies)
- [Installation](#installation)
  - [Download listed dependencies](#download-listed-dependencies)
  - [Begin Installation](#begin-installation)
- [Notes](#notes)
  - [Thanks to](#thanks-to)
## General Info
*   These are config files for the softwares I use

## My Setup
![Home](assets/home.png)
![Home](assets/home1.png)
* Os: Artix Linux(openrc)
* Wm: AwesomeWM
* Shell: zsh
* Terminal: Alacritty/Wezterm
* Compositor: picom
* App Launcher: rofi
* Editor: vscode/neovim

## Dependencies
* Arch based distro
```
# From standard repos
sudo pacman -S playerctl brightnessctl wezterm rofi flameshot lua53 luarocks 
```
```
# Change AUR-helper if needed
yay -Syu picom-ibwaghan-git awesome-git inotify-tools alsa-utils alsa-tools wirelesstools jq checkupdates --needed
```


## Installation
### Download listed dependencies
* See [Dependencies](#dependencies)
### Begin Installation
* Clone this repository
```shell
git clone https://github.com/K9H9/Config $HOME/awesome-config

```

## Notes
### Thanks to
* [nuxshed](https://github.com/nuxshed/dotfiles)
* [rxyhn](https://github.com/rxyhn)
* [JavaCafe01](https://github.com/JavaCafe01)


