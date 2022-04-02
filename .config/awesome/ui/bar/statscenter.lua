local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")
local gooey = require "ui.gooey"


local app_factory = function(icon,exec)
  return gooey.make_button {
    icon = icon,
    bg = beautiful.darker_bg,
    hover = true,
    width = 80,
    height = 80,
    margins = 20,
    exec = function()
      awful.spawn(exec)
    end,
  }
end

local app_gimp = app_factory(beautiful.gimp, "gimp")
local app_discord = app_factory(beautiful.discord,"discord")
local site_gmail = app_factory(beautiful.gmail,"firefox https://mail.google.com")
local site_github = app_factory(beautiful.github, "firefox https://github.com")
local app_code = app_factory(beautiful.vscode,"code")
local app_firefox = app_factory(beautiful.firefox,"firefox")
local app_terminal = app_factory(beautiful.spotify,"spotify")
local site_artix = app_factory(beautiful.distro_logo, "firefox https://wiki.archlinux.org/")


local apps = wibox.widget {
  layout = wibox.layout.grid,
  spacing = 8,
  forced_num_cols = 4,
  forced_num_rows = 2,
  app_gimp,
  app_firefox,
  site_github,
  app_code,
  app_discord,
  site_gmail,
  app_terminal,
  site_artix
}

local calendar = wibox.widget {
  widget = wibox.container.background,
  bg = beautiful.darker_bg,
  forced_width = 100,
  forced_height = 100,
  {
    widget = wibox.container.margin,
    top = 25,
    bottom = 20,
    left = 3,
    rigth = 9,
    {
      layout = wibox.layout.fixed.vertical,
      {
        widget = wibox.widget.textclock "%A",
        font = beautiful.font_name .. " Bold 9",
        align = "center",
      },
      {
        widget = wibox.widget.textclock(helpers.colorize_text("%d", beautiful.xcolor4)),
        font = beautiful.font_name .. " Bold 30",
        align = "center",
      },
      {
        widget = wibox.widget.textclock "%b",
        font = beautiful.font_name .. "Bold 12",
        align = "center",
      },
    },
  },
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 6)
  end,
}

awful.screen.connect_for_each_screen(function(s)
  s.mypopup = wibox({
        screen = 3,
        type = "dock",
        ontop = true,
        x = 1920 - (beautiful.panel_width)-dpi(25),
        y = -dpi(500),
        width = beautiful.panel_width,
        height = dpi(450),
        visible = true
    })

    s.mypopup.widget = wibox.widget {
        {
            {
              {
                apps,
                calendar,
                layout = wibox.layout.fixed.horizontal,
                spacing = 30,
              },
              {
                {
                  widget = wibox.container.background,
                  bg = beautiful.darker_bg,
                  shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 6)
                  end,
                  forced_height = 400,
                  forced_width = 150,
                },
                spacing = 30,
                {
                  widget = wibox.container.background,
                  bg = beautiful.darker_bg,
                  shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 6)
                  end,
                  forced_height = 400,
                  forced_width = 300,
                },
                layout = wibox.layout.fixed.horizontal,
                widget = wibox.container.margin,
              },
              layout = wibox.layout.fixed.vertical,
              spacing = 20,
            },
            widget = wibox.container.margin,
            margins = 20,
          },
        bg = beautiful.xbackground,
        widget = wibox.container.background
    }

    local popup_timed = rubato.timed {
        intro = 0.3,
        duration = 0.6,
        easing = rubato.quadratic,
        subscribed = function(pos)
            s.mypopup.y = pos 
        end
    }

    awesome.connect_signal("popup::open", function()
        if s.mypopup.y == -dpi(500) then
            popup_timed.target = 0 +dpi(25)
        else
            popup_timed.target = -dpi(500)
        end
    end) 
end)
