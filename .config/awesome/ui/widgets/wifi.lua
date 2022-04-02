local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local wifi = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = beautiful.wifi_icon,
      stylesheet = " * { stroke: " .. beautiful.darker_bg .. " }",
      valign = "center",
      halign = "center",
      forced_width = 30,
    },
    widget = wibox.container.margin,
    margins = 8,
  },
  bg = beautiful.wifi_off,
  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 6, 0)
  end,
}


local wifitooltip = awful.tooltip {};
wifitooltip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
wifitooltip.preferred_alignments = {"middle", "front", "back"}
wifitooltip.mode = "inside"
wifitooltip:add_to_object(wifi)
wifitooltip.text = ""

awful.widget.watch("/bin/sh -c $HOME/.config/awesome/signal/awesome_utils/wifi.sh", 1, function(widget, stdout)
  local up = stdout
  wifitooltip.text = up
  if (string.find(up, "Not")) then
    wifi.bg = beautiful.wifi_off
  else
    wifi.bg = beautiful.wifi_on
  end
end)



local s = false 
wifi:buttons {
  awful.button({}, 1, function()
    s = not s
    if s then
      wifi.bg = down
      awful.spawn("notify-send 'WiFi turned off'")
      awful.spawn("nmcli connection down Mobi1")
    else
      wifi.bg = up
      awful.spawn("notify-send 'WiFi turned on'")
      awful.spawn("nmcli connection up Mobi1")
    end
  end),
  awful.button({}, 3, function()
    awful.spawn("alacritty -e nmtui")
  end),
}




return wifi
