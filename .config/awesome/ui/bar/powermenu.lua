local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")


local function create_boxed_widget(widget_to_be_boxed, width, height, inner_pad)
    local box_container = wibox.container.background()
    box_container.bg = beautiful.darker_bg
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(5)

    local inner = dpi(0)

    if inner_pad then inner = 10 end

    local boxed_widget = wibox.widget {
        {
            widget_to_be_boxed,
            margins = inner,
            widget = wibox.container.margin
        },
        widget = box_container,
        color = "#FF000000",
    }

    return boxed_widget
end



-- Wifi
local wifi_text = wibox.widget{
    markup = helpers.colorize_text("WiFi", beautiful.xcolor8),
    font = beautiful.font_name .. "9",
    widget = wibox.widget.textbox
}

local wifi_ssid = wibox.widget{
    markup = "Offline",
    font = beautiful.font_name .. "bold 11",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local wifi = wibox.widget{
    wifi_text,
    nil,
    wifi_ssid,
    layout = wibox.layout.align.vertical
}

awesome.connect_signal("signal::network", function(status, ssid)
    wifi_ssid.markup = ssid
    wifi_text.markup = "Wifi" 
    if status == false then
        wifi_text.markup = "Ethernet"
        wifi_ssid.markup = "eth0"
    end
end)


--Bluetooth
local bluetooth_text = wibox.widget{
    markup = helpers.colorize_text("Bluetooth", beautiful.xcolor8),
    font = beautiful.font_name .. "9",
    widget = wibox.widget.textbox
}

local bluetooth_dev = wibox.widget{
    markup = "Offline",
    font = beautiful.font_name .. "bold 11",
    valign = "bottom",
    widget = wibox.widget.textbox
}

local bluetooth = wibox.widget{
    bluetooth_text,
    nil,
    bluetooth_dev,
    layout = wibox.layout.align.vertical
}

awful.widget.watch("/bin/sh -c $HOME/.config/awesome/signal/awesome_utils/bluetooth.sh", 1, function(widget, stdout)
        bluetooth_dev.markup = stdout
end)
-- awesome.connect_signal("signal::bluetoothwork", function(dev)
--     bluetooth_dev.markup = "online"
-- end)

-- Battery
local batt_text = wibox.widget{
    markup = helpers.colorize_text("Battery", beautiful.xcolor8),
    font = beautiful.font_name .. "9",
    valign = "center",
    widget = wibox.widget.textbox
}

local batt_perc = wibox.widget{
    markup = "N/A",
    font = beautiful.font_name .. "bold 11",
    valign = "center",
    widget = wibox.widget.textbox
}

local batt_bar = wibox.widget {
    max_value = 100,
    value = 20,
    background_color = beautiful.transparent,
    color = beautiful.xcolor0,
    widget = wibox.widget.progressbar
}

local batt = wibox.widget{
    batt_bar,
    {
        {
            batt_text,
            nil,
            batt_perc,
            -- spacing = dpi(5),
            layout = wibox.layout.align.vertical
        },
        margins = 10,
        widget = wibox.container.margin
    },
    layout = wibox.layout.stack
}

local batt_val = 0
local batt_charger

awesome.connect_signal("signal::battery", function(value)
    batt_val = value
    awesome.emit_signal("widget::battery")
end)

awesome.connect_signal("signal::charger", function(state)
    batt_charger = state
    awesome.emit_signal("widget::battery")
end)

awesome.connect_signal("widget::battery", function()
    local b = batt_val
    local fill_color = beautiful.xcolor2 .. "88"

    if batt_charger then
        fill_color = beautiful.xcolor2
    else
        if batt_val <= 15 then
            fill_color = beautiful.xcolor1 .. "33"
        end
    end

    batt_perc.markup = b .. "%"
    batt_bar.value = b
    batt_bar.color = fill_color
end)



    
local wifi_boxed = create_boxed_widget(wifi, dpi(110), dpi(55), true)
local batt_boxed = create_boxed_widget(batt, dpi(110), dpi(55))
local bluetooth_boxed = create_boxed_widget(bluetooth, dpi(110), dpi(55), true)


awful.screen.connect_for_each_screen(function(s)
        local buttons = require "ui.buttons"
        local prompt_button = function(icon, run, color)
            return buttons.prompt_button {
              icon = icon,
              alt_color = color,
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
        local execute_button = function(icon, func, color)
            return buttons.make_button {
              icon = icon,
              alt_color = color,
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
        local get_permission = function(icon, state, color)
            return buttons.yesno_button {
              icon = icon,
              alt_color = color,
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
            get_permission(beautiful.yes,"yes", beautiful.xcolor2),
            get_permission(beautiful.cross,"no",beautiful.xcolor1),
        }
        local menu = wibox.widget {
            layout = wibox.layout.grid,
            spacing = 8,
            forced_num_cols = 1,
            forced_num_rows = 4,
            prompt_button(beautiful.shutdown, "sudo shutdown -p now", beautiful.xcolor1),
            prompt_button(beautiful.logout, "awesome-client 'awesome.quit()'", beautiful.xcolor2),
            prompt_button(beautiful.refresh_icon, "/usr/lib/openrc/bin/reboot", beautiful.xcolor3),
            execute_button(beautiful.lock, lock_screen_show, beautiful.xcolor4)
        }
       
    s.powermenu = wibox({
        screen = screen.primary,
        type = "popup",
        ontop = true,
        x = -600,
        y = screen_height - dpi(208) - dpi(15),
        width = dpi(190),
        height = dpi(208),
        visible = true
    })

    s.powermenu.widget = wibox.widget {
        {
            {
                {
                    wifi_boxed,
                    spacing = 13,
                    batt_boxed,
                    spacing = 13,
                    bluetooth_boxed,
                    layout = wibox.layout.fixed.vertical
                },
                spacing = 15,
                {
                    menu,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 10
                },
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.margin,
            margins = 15,
        },
        bg = beautiful.xbackground,
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
        type = "popup",
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
                        right = 55,
                    },
                    layout = wibox.layout.fixed.vertical,
            },
            widget = wibox.container.margin,
            margins = 15,
        },
        bg = beautiful.xbackground,
        widget = wibox.container.background,
     }
end)