
local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local naughty = require "naughty"
local wibox = require "wibox"
local helpers = require "helpers"

local dnd = wibox.widget {
  {
    {
      id = "image_mode",
      widget = wibox.widget.imagebox,
      image = beautiful.dark,
      stylesheet = " * { stroke: " .. beautiful.darker_bg .. " }",
      forced_width = 28,
      valign = "center",
      halign = "center",
    },
    widget = wibox.container.margin,
    margins = 11,
  },
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 6, 0)
  end,
  widget = wibox.container.background,
  bg = beautiful.bg_normal,
}


local on = beautiful.bg_bluetooth_on
local off = beautiful.bg_bluetooth_off


dnd:buttons {
  awful.button({}, 1, function()
    if theme == themes[2] then
      dnd.bg = off
      awful.spawn.with_shell("~/.config/awesome/signal/awesome_utils/light.sh")
    else
      dnd.bg = on
      awful.spawn.with_shell("~/.config/awesome/signal/awesome_utils/dark.sh")
    end
  end),
}


return dnd