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
      width = 54,
      height = 54,
      margins = 10,
      exec = function()
        awful.spawn.with_shell(exec)
      end,
    }
end
local execute_button = function(icon, func)
    return gooey.make_button {
      icon = icon,
      bg = beautiful.darker_bg,
      hover = true,
      width = 54,
      height = 54,
      margins = 10,
      exec = function()
        func()
      end,
    }
end
local prompt_button = function(icon, exec)
    return gooey.make_button {
      icon = icon,
      bg = beautiful.darker_bg,
      hover = true,
      width = 54,
      height = 54,
      margins = 10,
      exec = function()
        awesome.emit_signal("prompt::show", exec)
      end,
    }
end

local menu = wibox.widget {
    layout = wibox.layout.grid,
    spacing = 8,
    forced_num_cols = 1,
    forced_num_rows = 4,
    prompt_button(beautiful.shutdown, "notify-send testi"),
    menubutton(beautiful.logout, "awesome-client 'awesome.quit()'"),
    menubutton(beautiful.refresh_icon, "sudo reboot"),
    execute_button(beautiful.lock, lock_screen_show)
}
awful.screen.connect_for_each_screen(function(s)
    s.powermenu = wibox({
        screen = screen.primary,
        type = "dock",
        ontop = true,
        x = -600,
        y = screen_height - dpi(208) - dpi(15),
        width = dpi(145*2),
        height = dpi(208),
        visible = true
    })

    s.powermenu.widget = wibox.widget {
        {
            {
                {
                    bg = beautiful.darker_bg,
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 6)
                    end,
                    widget = wibox.container.background,
                    forced_height = 100,
                    forced_width = 270, 
                },
                spacing = 15,
                {
                    menu,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 10
                },
                layout = wibox.layout.fixed.horizontal,
                margins = 10,
            },
            widget = wibox.container.margin,
            margins = 15,
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
        if s.powermenu.x == -600 then
            popup_timed.target = beautiful.wibar_width + dpi(20)
        else
            popup_timed.target = -600
        end
    end)
end)