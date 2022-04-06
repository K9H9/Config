
local awful = require("awful")
local naughty = require("naughty")

local update_interval = 5
local bluetoothwork_script = [[
  sh -c "
  bluetoothctl info | egrep "Name" | cut -d " " -f 2h
  "]]

awful.widget.watch(bluetoothwork_script, update_interval, function(_, stdout)
    local bluetooth_ssid = stdout
    local bluetooth_status = true

    if bluetooth_ssid == "" then
        bluetooth_status = false
    end

    bluetooth_ssid = string.gsub(bluetooth_ssid, '^%s*(.-)%s*$', '%1')
    awesome.emit_signal("signal::bluetoothwork", bluetooth_status, bluetooth_ssid)
end)
