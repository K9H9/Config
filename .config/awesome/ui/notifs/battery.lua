local gfs = require("gears.filesystem")
local naughty = require("naughty")

local display_high = true
local display_low = true
local display_charge = true

awesome.connect_signal("signal::battery", function(percentage)
    local value = percentage

    -- only display message if its not charging and low
    if value < 16 and display_low then
        naughty.notification({
            title = "Battery Status",
            text = "Running low at " .. value .. "%",
            image = gfs.get_configuration_dir() .. "icons/ghosts/battery.png"
        })
        display_low = false
    end

    -- only display message once if its fully charged and high
    if display_high and value > 90 then
        naughty.notification({
            title = "Battery Status",
            text = "Fully charged!",
            image = gfs.get_configuration_dir() .. "icons/ghosts/battery.png"

        })
        display_high = false
    end

    -- only display once if charging
    if display_charge then
        naughty.notification({
            title = "Battery Status",
            text = "Charging",
            image = gfs.get_configuration_dir() ..
                "icons/ghosts/battery_charging.png"
        })
        display_charge = false
    end

    if value < 88 and value > 18 then
        display_low = true
        display_high = true
    end

    

end)
