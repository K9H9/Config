local awful = require("awful")
local naughty = require("naughty")

local update_interval = 5
local network_script = [[
  sh -c "
  iwgetid -r
  "]]

awful.widget.watch(network_script, update_interval, function(_, stdout)
    local net_ssid = stdout
    local net_status = true

    if net_ssid == "" then
        net_status = false
    end

    net_ssid = string.gsub(net_ssid, '^%s*(.-)%s*$', '%1')
    awesome.emit_signal("signal::network", net_status, net_ssid)
end)
