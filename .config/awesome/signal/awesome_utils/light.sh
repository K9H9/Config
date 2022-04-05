#!/bin/sh

sed -i "3s/.*/gtk-theme-name=Catppuccin-blue/g" ~/.config/gtk-3.0/settings.ini
sed -i "35s/.*/theme = themes[1]/g" ~/.config/awesome/rc.lua 
sed -i "11s/.*/color_scheme = "Catppuccin","
awesome-client "awesome.restart()"