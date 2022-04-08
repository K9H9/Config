
local awful = require("awful")
local naughty = require("naughty")

local update_interval = 5
local bluetoothwork_script = [[
  sh -c "
  bluetoothctl info | egrep "Name" | cut -d " " -f 2
  "]]

awful.widget.watch(bluetoothwork_script, update_interval, function(stdout)
  local bluetooth_ssid = stdout

  -- bluetooth_ssid = string.gsub(bluetooth_ssid, '^%s*(.-)%s*$', '%1')
    
  awesome.emit_signal("signal::bluetoothwork", to_string(bluetooth_ssid))
end)
