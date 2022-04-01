
local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local naughty = require "naughty"
local wibox = require "wibox"
local helpers = require "helpers"

local dnd = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = gears.filesystem.get_configuration_dir() .. "icons/moon.svg",
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

local dndtip = awful.tooltip {};
dndtip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
dndtip.preferred_alignments = {"middle", "front", "back"}
dndtip.mode = "inside"
dndtip:add_to_object(dnd)
dndtip.text = "Notifications on"

local on = beautiful.bg_bluetooth_on
local off = beautiful.bg_bluetooth_off
local s = true
dnd:buttons {
  awful.button({}, 1, function()
    s = not s
    if s then
      dnd.bg = off
      naughty.resume()
      dndtip.text = "Notifications on"
    else
      dnd.bg = on
      naughty.suspend()
      dndtip.text = "Notifications off"
    end
  end),
}

return dnd