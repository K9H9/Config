local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local helpers = require "helpers"

local slider = wibox.widget {
  bar_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 2.5)
  end,
  bar_height = 10,
  bar_color = beautiful.lighter_bg,
  bar_active_color = beautiful.xcolor2,
  handle_shape = gears.shape.circle,
  handle_color = beautiful.xcolor2,
  handle_width = 17,
  value = 25,
  widget = wibox.widget.slider,
}


local bri_slider = wibox.widget {
  {
    widget = wibox.widget.imagebox,
    image = beautiful.brightness_icon,
    stylesheet = " * { stroke: " .. beautiful.xcolor2 .. " }",
    forced_width = 19,
    valign = "center",
    halign = "center",
  },
  slider,
  layout = wibox.layout.fixed.horizontal,
  spacing = 15,
}

local britip = awful.tooltip {};
britip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
britip.preferred_alignments = {"middle", "front", "back"}
britip.mode = "inside"
britip:add_to_object(bri_slider)
britip.text = ""

awesome.connect_signal("signal::brightness", function(value)
  slider.value = value
  britip.text = "Brightness: " .. value .. "%"
end)

slider:connect_signal("property::value", function(_, value)
  awful.spawn.with_shell("brightnessctl s " .. value .. "%")
end)

return bri_slider
