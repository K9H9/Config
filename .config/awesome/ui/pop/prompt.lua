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
      width = 75,
      height = 75,
      margins = 20,
      exec = function()
        exec()
      end,
    }
end
local prompt_button = function(icon, exec)
    return gooey.make_button {
      icon = icon,
      bg = beautiful.darker_bg,
      hover = true,
      width = 75,
      height = 75,
      margins = 25,
      exec = function()
        awesome.emit_signal("prompt::hide")
      end,
    }
end

local conf_prompt = wibox.widget {
    layout = wibox.layout.grid,
    spacing = 45,
    forced_num_cols = 2,
    forced_num_rows = 1,
    menubutton(beautiful.yes, function()
        awesome.connect_signal("prompt::show", function(executable) 
            awful.spawn.with_shell(executable) 
        end)
    end),
    prompt_button(beautiful.cross),
}
awful.screen.connect_for_each_screen(function(s)
    
    s.prompt = wibox({
        screen = screen.primary,
        type = "dock",
        ontop = true,
        width = dpi(145*2),
        x = screen_width / 2 - dpi(145),
        y = screen_height / 2 - dpi(80),
        height = dpi(160),
        visible = false
    })

    s.prompt.widget = wibox.widget {
        {
            {
                    {
                        {
                            {
                                widget = wibox.widget.textbox,
                                text = "Are you sure you want to do that?",
                                font = beautiful.font_name .. "11",
                            },
                            widget = wibox.container.margin,
                            top = 14,
                            bottom = 14,
                            right = 14,
                            left = 24,
                        },
                        bg = beautiful.darker_bg,
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, 6)
                        end,    
                        widget = wibox.container.background,
                    },
                    {   
                        {
                            conf_prompt,
                            layout = wibox.layout.fixed.horizontal,
                            spacing = 15
                        },
                        widget = wibox.container.margin,
                        top = 30,
                        bottom = 15,
                        left = 70,
                        rigth = 55,
                    },
                    layout = wibox.layout.fixed.vertical,
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


    awesome.connect_signal("prompt::show", function(exec)
        s.prompt.visible = true
    end)
    awesome.connect_signal("prompt::hide", function()
        s.prompt.visible = false
    end)
end)