local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local helpers = require "helpers"

local slider = wibox.widget {
  bar_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height,2.50)
  end,
  bar_height = 10,
  bar_color = beautiful.lighter_bg,
  bar_active_color = beautiful.xcolor1,
  handle_shape = gears.shape.circle,
  handle_color = beautiful.xcolor1,
  handle_width = 17,
  value = 75,
  widget = wibox.widget.slider,
}


local vol_slider = wibox.widget {
  {
    widget = wibox.widget.imagebox,
    image = beautiful.volume_icon,
    stylesheet = " * { stroke: " .. beautiful.xcolor1 .. " }",
    forced_width = 20,
    valign = "center",
    halign = "center",
  },
  slider,
  layout = wibox.layout.fixed.horizontal,
  spacing = 15,
}

local voltip = awful.tooltip {};
voltip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
voltip.preferred_alignments = {"middle", "front", "back"}
voltip.mode = "inside"
voltip:add_to_object(vol_slider)
voltip.text = ""


awful.widget.watch("pamixer --get-volume",1, function(widget, vol)
  local value = vol or 0
  slider.value = tonumber(value)
  voltip.text = "Volume: " .. vol .. "%" 
end)
-- awesome.connect_signal("signal::volume", function(vol, muted)
-- end)


slider:connect_signal("property::value", function(_, value)
  awful.spawn.with_shell("pamixer --set-volume " .. value)
end)

return vol_slider
