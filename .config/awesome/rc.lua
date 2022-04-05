
pcall(require, "luarocks.loader")

-- Standard awesome library
local gfs = require("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")
local gears = require("gears")
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")


naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)

-- Initialize Theme
themes = {
    "catppuccin",
    "gruvbox-dark",
  }
  
theme = themes[1]
beautiful.init(gfs.get_configuration_dir() .. "theme/" .. theme .. "/theme.lua")

local nice = require("nice")
nice {
    titlebar_font = beautiful.font_name .. "10",
    titlebar_items = {
        left = "",
        right = {"minimize", "maximize", "close"},
        middle = "title",
    }
}

-- Import Configuration
require("configuration")
local function set_wallpaper(s)
     if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
    screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[s])
end)

require("signal")
require("ui")

-- Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)


