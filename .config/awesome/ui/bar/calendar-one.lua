local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")
local gooey = require "ui.gooey"

local styles = {}

styles.month   = { padding      = 5,
                   bg_color     = beautiful.darker_bg,
                   shape        = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 3.5)
                                end, 
}
styles.normal  = {  bg_color = beautiful.darker_bg,
                    shape    = function(cr, width, height)
                                gears.shape.rounded_rect(cr, width, height, 3.5)
                            end, }

styles.focus   = { fg_color = beautiful.xforeground,
                   bg_color = beautiful.lighter_bg,
                   padding      = 5,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = function(cr, width, height)
                                gears.shape.rounded_rect(cr, width, height, 3.5)
                            end, 
}
styles.add   = { fg_color = beautiful.xforeground,
                   bg_color = beautiful.lighter_bg,
                   padding      = 5,
                   markup   = function(t) return '<b>' .. r .. '</b>' end,
                   shape    = function(cr, width, height)
                                gears.shape.rounded_rect(cr, width, height, 3.5)
                            end, 
}
styles.header  = { fg_color = beautiful.xforeground,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = function(cr, width, height)
                                gears.shape.rounded_rect(cr, width, height, 3.5)
                            end, 
}
styles.weekday = { fg_color = beautiful.xforeground,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = function(cr, width, height)
                                gears.shape.rounded_rect(cr, width, height, 3.5)
                            end, 
}
local function decorate_cell(widget, flag, date)
    if flag=="monthheader" and not styles.monthheader then
        flag = "header"
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local ret = wibox.widget {
        {
            widget,
            margins = 5,
            widget  = wibox.container.margin
        },
        shape        = props.shape,
        fg           = props.fg_color,
        bg           = props.bg_color,
        widget       = wibox.container.background
    }
    return ret
end
local cal = wibox.widget {
    date     = os.date("*t"),
    font = beautiful.font_name .. "10",
    fn_embed = decorate_cell,
    widget   = wibox.widget.calendar.month,
    start_sunday = false,
}

awful.screen.connect_for_each_screen(function(s)
    s.calendar = wibox({
        screen = s,
        type = "dock",
        ontop = true,
        x = beautiful.wibar_width + dpi(20),
        y = 1100,
        width = dpi(200),
        height = dpi(220),
        visible = true
      })

    s.calendar.widget = wibox.widget {
        {
            
            cal,
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
            s.calendar.y = pos 
        end
    }

    awesome.connect_signal("calendar::open", function()
        if s.calendar.y == 1100 then
            popup_timed.target = screen_height - dpi(220) - dpi(20)
        else
            popup_timed.target = 1100
        end
    end) 
end)
