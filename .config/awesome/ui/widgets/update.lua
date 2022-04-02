local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi
local helpers = require "helpers"



local update = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = beautiful.refresh_icon,
      stylesheet = " * { fill: " .. beautiful.darker_bg .. " }",
      valign = "center",
      halign = "center",
      forced_width = 25,
    },
    widget = wibox.container.margin,
    margins = 12.5,
  },
  bg = beautiful.no_updates,
  widget = wibox.container.background,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 6, 0)
  end,
}
local updatetip = awful.tooltip {};
updatetip.shape = helpers.prrect(beautiful.border_radius, false, true, true, false)
updatetip.preferred_alignments = {"middle", "front", "back"}
updatetip.mode = "inside"
updatetip:add_to_object(update)
updatetip.text = ""


awful.widget.watch("/bin/sh -c $HOME/.config/awesome/signal/awesome_utils/updates.sh", 1, function(widget, stdout)
  local up = stdout
  updatetip.text = up
  if (string.find(up, "No")) then
    update.bg = beautiful.no_updates
  else
    update.bg = beautiful.updates
  end
end)



return update
