-- rc.lua
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
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

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)

-- Initialize Theme
local theme = "ghosts"
beautiful.init(gfs.get_configuration_dir() .. "theme/" .. theme .. "/theme.lua")

-- Import Configuration
require("configuration")
local function set_wallpaper(s)
     --Wallpaper
     if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)
-- Screen Padding and Tags
awful.screen.connect_for_each_screen(function(s)
    -- Screen padding
    screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}
    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[s])
end)
-- Import Daemons and Widgets
require("signal")
require("ui")

-- Create a launcher widget and a main menu


-- Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

-- Use the following for a less intense, more battery saving GC
-- collectgarbage("setpause", 160)
-- collectgarbage("setstepmul", 400)


-- local wibox = require("wibox")
-- local helpers = require("helpers")
-- local gears = require("gears")
-- local create_button = function(symbol, color, command, playpause)
--     local icon = wibox.widget {
--         markup = helpers.colorize_text(symbol, color),
--         font = "Iosevka Nerd Font 16",
--         align = "center",
--         valigin = "center",
--         widget = wibox.widget.textbox()
--     }
--     local button = wibox.widget {
--         icon,
--         forced_height = 30,
--         forced_width = 30,
--         widget = wibox.container.background
--     }
--     awesome.connect_signal("bling::playerctl::status", function(playing)
--         if playpause then
--             if playing then
--                 icon.markup = helpers.colorize_text("", color)
--             else
--                 icon.markup = helpers.colorize_text("", color)
--             end
--         end
--     end)
--     button:buttons(gears.table.join(
--                        awful.button({}, 1, function() command() end)))
--     button:connect_signal("mouse::enter", function()
--         icon.markup = helpers.colorize_text(icon.text, beautiful.xforeground)
--     end)
--     button:connect_signal("mouse::leave", function()
--         icon.markup = helpers.colorize_text(icon.text, color)
--     end)
--     return button
-- end
-- local play_command =
--     function() awful.spawn.with_shell("playerctl play-pause") end
-- local prev_command = function() awful.spawn.with_shell("playerctl previous") end
-- local next_command = function() awful.spawn.with_shell("playerctl next") end
-- local playerctl_play_symbol = create_button("", beautiful.xcolor4,
--                                             play_command, true)
-- local playerctl_prev_symbol = create_button("玲", beautiful.xcolor4,
--                                             prev_command, false)
-- local playerctl_next_symbol = create_button("怜", beautiful.xcolor4,
--                                             next_command, false)
-- local art = wibox.widget {
--     image = gfs.get_configuration_dir() .. "images/me.png",
--     resize = true,
--     forced_width = 200,
--     -- clip_shape = helpers.rrect(12),
--     widget = wibox.widget.imagebox
-- }
-- awesome.connect_signal("bling::playerctl::title_artist_album",
--                        function(_, _, art_path)
--     -- Set art widget
--     art:set_image(gears.surface.load_uncached(art_path))
-- end)
-- local draggable_player = wibox({
--     visible = true,
--     ontop = true,
--     width = 200,
--     height = 265,
--     bg = beautiful.xbackground .. 00,
--     widget = {
--         {
--             art,
--             bg = beautiful.xbackground .. 00,
--             shape = helpers.rrect(12),
--             border_width = beautiful.widget_border_width + 1,
--             border_color = beautiful.widget_border_color,
--             widget = wibox.container.background
--         },
--         helpers.vertical_pad(15),
--         {
--             {
--                 playerctl_prev_symbol,
--                 playerctl_play_symbol,
--                 playerctl_next_symbol,
--                 layout = wibox.layout.flex.horizontal
--             },
--             forced_height = 50,
--             bg = beautiful.xcolor0,
--             shape = helpers.rrect(12),
--             widget = wibox.container.background
--         },
--         layout = wibox.layout.fixed.vertical
--     }
-- })
-- draggable_player:connect_signal("mouse::enter", function()
--     awful.mouse.wibox.move(draggable_player)
-- end)


-- Add a titlebar if titlebars_enabled is set to true in the rules.

client.connect_signal("request::titlebars", function(c)
    local top_titlebar = awful.titlebar(c, {
        height  = 20,
    })

    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    top_titlebar : setup {
        { -- Left
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- EOF ------------------------------------------------------------------------
