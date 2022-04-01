local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi

local wifi = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = "/home/koho/Downloads/power.svg",
      stylesheet = " * { stroke: " .. beautiful.darker_bg .. " }",
      forced_width = dpi(35),
      valign = "center",
      halign = "center",
    },
    widget = wibox.container.margin,
    margins = dpi(3),
  },
  bg = beautiful.bg_bluetooth_off,
  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.squircle(cr, width, height, 2, 0)
  end,
}


return wifi
