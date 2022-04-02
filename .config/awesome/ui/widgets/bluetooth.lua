local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local bluetooth = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = beautiful.bluetooth_icon,
      stylesheet = " * { stroke: " .. beautiful.darker_bg .. " }",
      valign = "center",
      halign = "center",
      forced_width = 25,
    },
    widget = wibox.container.margin,
    margins = 12.5,
  },
  bg = beautiful.bg_bluetooth_off,
  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 6, 0)
  end,
}


local bluetoothtip = awful.tooltip {};
bluetoothtip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
bluetoothtip.preferred_alignments = {"middle", "front", "back"}
bluetoothtip.mode = "inside"
bluetoothtip:add_to_object(bluetooth)
bluetoothtip.text = ""


awful.widget.watch("/bin/sh -c $HOME/.config/awesome/signal/awesome_utils/bluetooth.sh", 1, function(widget, stdout)
  local up = stdout
  bluetoothtip.text = up
  if (string.find(up, "off")) then
    bluetooth.bg = beautiful.bg_bluetooth_off
  else
    bluetooth.bg = beautiful.bg_bluetooth_on
  end
end)






local s = true
bluetooth:buttons {
  awful.button({}, 1, function()
    s = not s
    if s then
      bluetooth.bg = beautiful.bg_bluetooth_off
      awful.spawn "bluetoothctl power off"
      awful.spawn "notify-send 'Bluetooth off' "
    else
      bluetooth.bg = beautiful.bg_bluetooth_on
      awful.spawn "bluetoothctl power on"
      awful.spawn "notify-send 'Bluetooth on' "
    end
  end),
  awful.button({}, 3, function()
    awful.spawn("alacritty -e blueman-manager")
  end),
}

return bluetooth
