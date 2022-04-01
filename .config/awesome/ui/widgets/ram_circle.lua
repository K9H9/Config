local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local ram_circle = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = "/home/koho/Downloads/memory.svg",
      stylesheet = " * { fill: " .. beautiful.xcolor7 .. " }",
      valign = "center",
      halign = "center",
    },
    widget = wibox.container.margin,
    margins = 40,
  },
  value = 0.5,
  max_value = 1,
  min_value = 0,
  color = beautiful.xcolor7,
  border_color = beautiful.lighter_bg,
  border_width = 7,
  widget = wibox.container.radialprogressbar,
}

awesome.connect_signal("signal::ram", function(used, total)
  ram_circle.value = (used / total)
end)

return ram_circle
