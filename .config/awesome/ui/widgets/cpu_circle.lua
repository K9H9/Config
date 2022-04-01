local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local cpu_circle = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = "/home/koho/Downloads/cpu.svg",
      stylesheet = " * { stroke: " .. beautiful.xcolor4 .. " }",
      valign = "center",
      halign = "center",
    },
    widget = wibox.container.margin,
    margins = 40,
  },
  value = 0.5,
  max_value = 1,
  min_value = 0,
  color = beautiful.xcolor4,
  border_color = beautiful.lighter_bg,
  border_width = 7,
  widget = wibox.container.radialprogressbar,
}

awesome.connect_signal("signal::cpu", function(used)
  cpu_circle.value = used / 100
end)

return cpu_circle


