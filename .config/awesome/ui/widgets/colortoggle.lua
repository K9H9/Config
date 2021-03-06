
local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local naughty = require "naughty"
local wibox = require "wibox"
local helpers = require "helpers"

local color_change_button = wibox.widget {
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
    id = "inner_margin",
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

color_change_button:connect_signal("mouse::enter", function()
  color_change_button.inner_margin.margins = 11 * 0.85
end)

color_change_button:connect_signal("mouse::leave", function()
  color_change_button.inner_margin.margins = 11  
end)

local s = true
    
color_change_button:buttons {
  awful.button({}, 1, function()
    s = not s
    if s then
      awful.spawn.with_shell("~/.config/awesome/signal/awesome_utils/light.sh")
    else
      awful.spawn.with_shell("~/.config/awesome/signal/awesome_utils/dark.sh")
    end
  end),
}


return color_change_button