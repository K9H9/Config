local awful = require "awful"

local update_interval = 10
local battery_status_script = [[
  sh -c "
  echo $(cat /sys/class/power_supply/BAT0/capacity)
  "]]

-- Periodically get cpu info
awful.widget.watch(battery_status_script, update_interval, function(widget, stdout)
  local status = stdout
  awesome.emit_signal("signal::battery", tonumber(status))
end)