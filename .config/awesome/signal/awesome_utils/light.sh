#!/bin/sh

sed -i "3s/.*/gtk-theme-name=Catppuccin-blue/g" ~/.config/gtk-3.0/settings.ini
# sed -i "35s/.*/theme = themes[1]/g" ~/.config/awesome/rc.lua 
sed -i "11s/.*/color_scheme = "Catppuccin",/g" ~/.config/wezterm/wezterm.lua
# sed -i "205s~.*~theme.wallpaper = gfs.get_configuration_dir() .. 'images~cat-sound.png'~g" #~/.config/awesome/theme/catppuccin/theme.lua
xrdb -merge .Xresources
awesome-client "awesome.restart()"
sleep 4
feh --bg-fill ~/.config/awesome/images/cat-sounf.png