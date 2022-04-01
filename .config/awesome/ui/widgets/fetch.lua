local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local helpers = require "helpers"

local fetch = wibox.widget {
    {
        awful.widget.watch("/bin/sh -c /home/koho/Code/scripts/awesome_utils/awesome-fetch.sh", 1, function(widget, stdout)
            widget.markup = [[<span color="]]..beautiful.xcolor10..[[">]]..stdout..[[</span>]]
            widget.font = beautiful.font_name .. "11" 
        end),
        widget = wibox.container.margin,
        margins = 20
    },
    layout = wibox.layout.fixed.horizontal,
}

return fetch
