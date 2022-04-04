local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")

    
awful.screen.connect_for_each_screen(function(s)
        local buttons = require "ui.buttons"
        local prompt_button = function(icon, run)
            return buttons.prompt_button {
              icon = icon,
              bg = beautiful.darker_bg,
              hover = true,
              width = 54,
              height = 54,
              margins = 10,
              exec = function()
                s.prompt.visible = true
                function run_this()
                    local runit = run
                return runit
                end
              end
            }
        end
        local execute_button = function(icon, func)
            return buttons.make_button {
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
        local get_permission = function(icon, state)
            return buttons.yesno_button {
              icon = icon,
              bg = beautiful.darker_bg,
              hover = true,
              width = 75,
              height = 75,
              margins = 20,
              exec = function()
                if (state == "no") then
                    s.prompt.visible = false
                else
                    awful.spawn.with_shell(run_this())
                end
              end,
            }
        end                       
        
        local conf_prompt = wibox.widget {
            layout = wibox.layout.grid,
            spacing = 45,
            forced_num_cols = 2,
            forced_num_rows = 1,
            get_permission(beautiful.yes,"yes"),
            get_permission(beautiful.cross,"no"),
        }
        local menu = wibox.widget {
            layout = wibox.layout.grid,
            spacing = 8,
            forced_num_cols = 1,
            forced_num_rows = 4,
            prompt_button(beautiful.shutdown, "sudo shutdown"),
            prompt_button(beautiful.logout, "awesome-client 'awesome.quit()'"),
            prompt_button(beautiful.refresh_icon, "sudo reboot"),
            execute_button(beautiful.lock, lock_screen_show)
    }
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
end)