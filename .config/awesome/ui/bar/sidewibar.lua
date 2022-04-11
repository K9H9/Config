-- wibar.lua
-- Wibar (top bar)
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")

-- Awesome Panel -----------------------------------------------------------


local awesome_icon = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = beautiful.distro_logo,
            valign = "center",
            align = "center",
            halign = "center"
        },
        margins = dpi(7),
        widget = wibox.container.margin
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5, 0)
    end,
    bg = beautiful.darker_bg,
    widget = wibox.container.background
}


awesome_icon:connect_signal("mouse::enter", function()
    awesome_icon.bg = beautiful.lighter_bg
    awesome.emit_signal("panel::open")
end)

awesome_icon:connect_signal("mouse::leave", function()
    awesome_icon.bg = beautiful.darker_bg
end)


local shutdown_menu = wibox.widget {
    {
        {
                    widget = wibox.widget.imagebox,
                    image = beautiful.menu_icon,
                    halign = "center",
                    valign = "center",
        },
        widget = wibox.container.margin,
        margins = dpi(5)
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5, 0)
    end,
    forced_height = 42,
    bg = beautiful.darker_bg,
    widget = wibox.container.background
}



shutdown_menu:connect_signal("mouse::enter", function()
    shutdown_menu.bg = beautiful.lighter_bg
    awesome.emit_signal("powermenu::open")
end)

shutdown_menu:connect_signal("mouse::leave", function()
    shutdown_menu.bg = beautiful.darker_bg
end)

local hourtextbox = wibox.widget.textclock("%H")
hourtextbox.markup = helpers.colorize_text(hourtextbox.text, beautiful.xcolor5)
hourtextbox.align = "center"
hourtextbox.valign = "center"
hourtextbox.font = beautiful.font_name .. "10"


local minutetextbox = wibox.widget.textclock("%M")
minutetextbox.align = "center"
minutetextbox.valign = "center"
minutetextbox.font = beautiful.font_name .. "10"

hourtextbox:connect_signal("widget::redraw_needed", function()
    hourtextbox.markup = helpers.colorize_text(hourtextbox.text, beautiful.xcolor5)
end)

minutetextbox:connect_signal("widget::redraw_needed", function()
    minutetextbox.markup = helpers.colorize_text(minutetextbox.text, beautiful.xforeground)
end)

awesome.connect_signal("chcolor", function()
    hourtextbox.markup = helpers.colorize_text(hourtextbox.text, beautiful.xcolor5)
    minutetextbox.markup = helpers.colorize_text(minutetextbox.text, beautiful.xforeground)
end)

local clock = wibox.widget {
    {
        {    
            hourtextbox,
            minutetextbox,
            layout = wibox.layout.fixed.vertical,
        },
        widget = wibox.container.margin, 
        top = 8, 
        bottom = 8,
    },
    bg = beautiful.darker_bg,
    widget = wibox.container.background,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5, 0)
    end,

}


clock:connect_signal("mouse::enter", function()
    awesome.emit_signal("calendar::open")
end)


-- Tasklist Buttons -----------------------------------------------------------

local tasklist_buttons = gears.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal("request::activate", "tasklist", {
            raise = true
        })
    end
end), awful.button({}, 3, function()
    awful.menu.client_list({
        theme = {
            width = 250
        }
    })
end), awful.button({}, 4, function()
    awful.client.focus.byidx(1)
end), awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
end))

-- Create the Wibar -----------------------------------------------------------

local final_systray = wibox.widget {
    mysystray_container,
    top = dpi(6),
    left = dpi(3),
    right = dpi(3),
    layout = wibox.container.margin
}
local function boxed_widget(widget)
    local boxed = wibox.widget {
        {
            widget,
            top = dpi(8),
            bottom = dpi(5),
            widget = wibox.container.margin
        },
        bg = beautiful.darker_bg,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5, 0)
        end,
        widget = wibox.container.background
    }
    return boxed
end

local function boxed_widget2(widget)
    local boxed = wibox.widget {
        {
            widget,
            top = dpi(3),
            bottom = dpi(3),
            widget = wibox.container.margin
        },
        bg = beautiful.lighter_bg,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5, 0)
        end,
        widget = wibox.container.background
    }

    return boxed
end

local function boxed_widget3(widget)
    local boxed = wibox.widget {
        {
            widget,
            top = dpi(8),
            bottom = dpi(5),
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5, 0)
        end,
        widget = wibox.container.background
    }
    return boxed
end

local wrap_widget = function(w)
    return {
        w,
        top = dpi(5),
        left = dpi(3),
        bottom = dpi(5),
        right = dpi(4),
        widget = wibox.container.margin
    }
end

local wrap_widget2 = function(w)
    return {
        w,
        left = dpi(20),
        right = dpi(20),
        widget = wibox.container.margin
    }
end

awful.screen.connect_for_each_screen(function(s)
    s.mylayoutbox = awful.widget.layoutbox(s)
    local layoutbox = wibox.widget {
        s.mylayoutbox,
        right = dpi(5),
        left = dpi(5),
        top = dpi(4),
        bottom = dpi(4),
        widget = wibox.container.margin
    }
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create layoutbox widget

    -- Create the wibox
    s.mywibox = wibox({
        position = beautiful.wibar_position,
        screen = screen.primary,
        type = "dock",
        ontop = true,
        width = beautiful.wibar_width,
        height = screen_height,
        visible = true
    })

    s.mypanel = wibox({
        screen = s,
        type = "dock",
        ontop = true,
        x = -400,
        y = 0,
        width = beautiful.panel_width,
        height = screen_height,
        visible = false,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 0, 0)
        end
    })

    s.mypanel.widget = wibox.widget {
        {
            {
                {
                    widget = wibox.widget.textclock(helpers.colorize_text("%a %m %Y, %H:%M",beautiful.lighter_bg)),
                    align = "center",
                    font = beautiful.font_name .. "11"
                },
                {
                    require("ui.notifs.notif-center"),
                    forced_height = dpi(800),
                    widget = wibox.container.constraint

                },
                layout = wibox.layout.fixed.vertical,
                spacing = 20
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        widget = wibox.container.background
    }
    s.mywibox:struts{
        left = beautiful.wibar_width
    }

    local panel_timed = rubato.timed {
        intro = 0.3,
        duration = 0.6,
        easing = rubato.quadratic,
        subscribed = function(pos)
            if pos <= (beautiful.panel_width * -1) then
                s.mypanel.visible = false
            end
            s.mypanel.x = pos - beautiful.panel_width
            s.mywibox.x = pos
        end
    }

    awesome.connect_signal("panel::open", function()
        if s.mywibox.x == 0 then
            s.mypanel.visible = true
            panel_timed.target = beautiful.panel_width
        else
            panel_timed.target = 0
        end
    end)

    -- Remove wibar on full screen
    local function remove_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = false
        else
            c.screen.mywibox.visible = true
        end
    end

    -- Remove wibar on full screen
    local function add_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = true
        end
    end

    client.connect_signal("property::fullscreen", remove_wibar)
    client.connect_signal("request::unmanage", add_wibar)

    -- Create the taglist widget

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        bg = beautiful.darker_bg,
        style = {
            bg = beautiful.xcolor0,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5, 0)
            end
        },
        layout = {
            spacing = dpi(10),
            layout = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                awful.widget.clienticon,
                margins = dpi(6),
                layout = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = function(self, c, index, clients)
                self:connect_signal('mouse::enter', function()
                    self.bg_temp = self.bg
                    self.bg = beautiful.xcolor0
                    awesome.emit_signal("bling::task_preview::visibility", s, true, c)
                end)
                self:connect_signal('mouse::leave', function()
                    self.bg = self.bg_temp
                    awesome.emit_signal("bling::task_preview::visibility", s, false, c)
                end)
            end
        }
    }

    -- Add widgets to the wibox
    s.mywibox.widget = wibox.widget {
        {
            layout = wibox.layout.align.vertical,
            expand = "none",
            {
                layout = wibox.layout.fixed.vertical,
                helpers.horizontal_pad(4),
                -- function to add padding
                {
                    {
                        awesome_icon,
                        margins = dpi(3),
                        widget = wibox.container.margin
                    },
                    margins = 3,
                    widget = wibox.container.margin
                },

                wrap_widget({
                    s.mytasklist,
                    left = dpi(2),
                    right = dpi(2),
                    widget = wibox.container.margin
                }),
            },
            {
                boxed_widget3({
                    wrap_widget({
                        widget = wibox.widget.textbox(" "),
                        top = dpi(4),
                        bottom = dpi(4),
                        widget = wibox.container.margin
                    }),
                    widget = wibox.container.constraint
                }),
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            {
                {
                    {
                        {
                            {
                                -- boxed_widget({
                                --     wrap_widget({
                                --         boxed_widget2(clock),
                                --         layout = wibox.layout.fixed.vertical
                                --     }),
                                --     left = dpi(2),
                                --     right = dpi(2),
                                --     widget = wibox.container.margin
                                -- }),
                                clock,
                                spacing = 10,
                                boxed_widget({
                                    layoutbox,
                                    spacing = dpi(1),
                                    layout = wibox.layout.fixed.vertical
                                }),
                                helpers.horizontal_pad(4),
                                layout = wibox.layout.fixed.vertical
                            },
                            widget = wibox.container.margin
                        },
                        left = dpi(1),
                        right = dpi(1),
                        widget = wibox.container.margin
                    },
                    {
                        shutdown_menu,
                        widget = wibox.container.margin,
                        margins = dpi(1)
                    },
                    layout = wibox.layout.fixed.vertical
                },
                widget = wibox.container.margin,
                margins = dpi(6)
            }
        },
        widget = wibox.container.background,
        bg = beautiful.xbackground
    }
end)