local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")
local gooey = require "ui.gooey"

local menubutton = function(icon, exec)
    return gooey.make_button {
      icon = icon,
      bg = beautiful.darker_bg,
      hover = true,
      width = 50,
      height = 50,
      margins = 10,
      exec = function()
        awful.spawn.with_shell(exec)
      end,
    }
end

local menu = wibox.widget {
    layout = wibox.layout.grid,
    spacing = 8,
    forced_num_cols = 3,
    forced_num_rows = 1,
    menubutton(beautiful.shutdown, "notify-send testi"),
    menubutton(beautiful.logout, "awesome-client 'awesome.quit()'"),
    menubutton(beautiful.refresh_icon, "reboot")
}
awful.screen.connect_for_each_screen(function(s)
    s.powermenu = wibox({
        screen = s,
        type = "dock",
        ontop = true,
        x = -200,
        y = screen_height - dpi(55) - dpi(15),
        width = dpi(145),
        height = dpi(55),
        visible = true
      })

    s.powermenu.widget = wibox.widget {
        {
            {
                menu,
                layout = wibox.layout.fixed.horizontal,
                spacing = 10
            },
            widget = wibox.container.margin,
            margins = 10,
        },
        bg = beautiful.xbackground,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 6)
        end,
        widget = wibox.container.background,
     }

    local popup_timed = rubato.timed {
        intro = 0.3,
        duration = 0.6,
        easing = rubato.quadratic,
        subscribed = function(pos)
            s.powermenu.x = pos
        end
    }

    awesome.connect_signal("powermenu::open", function()
        if s.powermenu.x == -200 then
            popup_timed.target = beautiful.wibar_width + dpi(20)
        else
            popup_timed.target = -200
        end
    end)
end)