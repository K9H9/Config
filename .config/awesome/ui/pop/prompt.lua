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
      width = 80,
      height = 30,
      margins = 10,
      exec = function()
        awful.spawn.with_shell(exec)
      end,
    }
end
local prompt_button = function(icon)
    return gooey.make_button {
      icon = icon,
      bg = beautiful.darker_bg,
      hover = true,
      width = 54,
      height = 54,
      margins = 10,
      exec = function()
        awesome.emit_signal("prompt::hide")
      end,
    }
end

local buttons = wibox.widget {
    spacing = 8,
    forced_num_cols = 2,
    forced_num_rows = 1,
    menubutton(beautiful.logout, "notify-send testi"),
    prompt_button(beautiful.refresh_icon),
}
awful.screen.connect_for_each_screen(function(s)
    s.prompt = wibox({
        screen = screen.primary,
        type = "dock",
        ontop = true,
        width = dpi(145*2),
        x = screen_width / 2 - dpi(145),
        y = screen_height / 2 - dpi(104),
        height = dpi(208),
        visible = false
    })

    s.prompt.widget = wibox.widget {
        {
            {
                {
                    buttons,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 10
                },
                layout = wibox.layout.fixed.vertical,
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

    awesome.connect_signal("prompt::show", function()
        s.prompt.visible = true
    end)
    awesome.connect_signal("prompt::hide", function()
        s.prompt.visible = false
    end)
end)