#!/bin/sh

sed -i "3s/.*/gtk-theme-name=gruvbox-dark-gtk/g" ~/.config/gtk-3.0/settings.ini
sed -i "35s/.*/theme = themes[2]/g" ~/.config/awesome/rc.lua 
sed -i "11s/.*/color_scheme = "Gruvbox-Dark","
awesome-client "awesome.restart()"