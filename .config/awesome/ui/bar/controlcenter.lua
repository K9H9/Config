local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")





awful.screen.connect_for_each_screen(function(s)
  s.mypopup1 = wibox({
        screen = screen.primary,
        type = "dock",
        ontop = true,
        x = 1920 - (beautiful.panel_width) - dpi(25),
        y = 1180,
        width = beautiful.panel_width,
        height = screen_height - dpi(500)-dpi(25),
        visible = true
    })

    s.mypopup1.widget = wibox.widget {
       {
            {
              {
                {
                  {
                      widget = require "ui.widgets.batterystatus",
                  },
                  margins = 20,
                  widget = wibox.container.margin,
                },
                widget = wibox.container.background,
                bg = beautiful.darker_bg,
                shape = function(cr, width, height)
                  gears.shape.rounded_rect(cr, width, height, 6)
                end,
                forced_height = 110,
                forced_width = 75,
              },
                {
                  {
                    {
                      {
                        widget = require "ui.widgets.vol_slider",
                      },
                      {
                        widget = require "ui.widgets.bri_slider",
                      },
                      layout = wibox.layout.flex.vertical,
                      spacing = 10,
                    },
                    margins = 20,
                    widget = wibox.container.margin,
                  },
                  widget = wibox.container.background,
                  bg = beautiful.darker_bg,
                  shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 6)
                  end,
                  forced_height = 110,
                  forced_width = 200,
                },
                {
                    {
                      {
                        { widget = require "ui.widgets.wifi" },
                        { widget = require "ui.widgets.bluetooth" },
                        { widget = require "ui.widgets.colortoggle" },
                        { widget = require "ui.widgets.update" },
                        layout = wibox.layout.flex.horizontal,
                        spacing = 30,
                      },
                      widget = wibox.container.margin,
                      top = 20,
                      bottom = 20,
                      left = 50,
                      right = 50,
                    },
                    widget = wibox.container.background,
                    bg = beautiful.darker_bg,
                    forced_height = 100,
                    shape = function(cr, width, height)
                      gears.shape.rounded_rect(cr, width, height, 6)
                    end,
                  },
                  layout = wibox.layout.fixed.vertical,
                  spacing = 20,
            },
            margins = 20,
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        widget = wibox.container.background,
    }

    local popup_timed = rubato.timed {
        intro = 0.3,
        duration = 0.6,
        easing = rubato.quadratic,
        subscribed = function(pos)
            s.mypopup1.y = pos 
        end
    }

    awesome.connect_signal("popup1::open", function()
        if s.mypopup1.y == 1180 then
            popup_timed.target = 1080 - (screen_height - dpi(500))
        else
            popup_timed.target = 1180
        end
    end) 
end)
