#!/bin/sh

sed -i "3s/.*/gtk-theme-name=gruvbox-dark-gtk/g" ~/.config/gtk-3.0/settings.ini
# sed -i "35s/.*/theme = themes[2]/g" ~/.config/awesome/rc.lua 
sed -i "11s/.*/color_scheme = "Gruvbox-Dark",/g" ~/.config/wezterm/wezterm.lua
# sed -i "205s/.*/theme.wallpaper = gfs.get_configuration_dir() .. 'images/gr-leaves.jpg'/g" ~/.config/awesome/theme/catppuccin/theme.lua
xrdb -merge .Xresources-gr-dark
awesome-client "awesome.restart()"
sleep 4
feh --bg-fill ~/.config/awesome/images/gr-leaves.jpg