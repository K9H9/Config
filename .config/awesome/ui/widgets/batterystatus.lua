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
  bar_active_color = beautiful.xcolor4,
  handle_width = 0,
  widget = wibox.widget.slider,
}

local bat_slider = wibox.widget {
  {
    widget = wibox.widget.imagebox,
    image = beautiful.battery_icon,
    stylesheet = " * { stroke: " .. beautiful.xcolor4 .. " }",
    forced_width = 19,
    valign = "center",
    halign = "center",
  },
  slider,
  layout = wibox.layout.fixed.horizontal,
  spacing = 15,
}
 
local batterytip = awful.tooltip {};
batterytip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
batterytip.preferred_alignments = {"middle", "front", "back"}
batterytip.mode = "inside"
batterytip:add_to_object(bat_slider)
batterytip.text = ""

awesome.connect_signal("signal::battery", function(value)
  slider.value = value
  batterytip.text = "Battery charge: " .. value .. "%"
end)


return bat_slider