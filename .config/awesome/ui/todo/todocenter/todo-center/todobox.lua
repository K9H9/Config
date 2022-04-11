local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local awful = require("awful")

local button = require("ui.widgets.button")

local todobox = {}

todobox.create = function(icon, title, message, bg, width)
    local time = os.date("%H:%M")
    local box = {}

    local dismiss = button.create_image_onclick(beautiful.delete_grey_icon,
                                                beautiful.delete_icon,
                                                function()
        _G.remove_todobox(box)
    end)
    dismiss.forced_height = dpi(14)
    dismiss.forced_width = dpi(14)

    box = wibox.widget {
        {
            {
                {
                    {
                        {
                            {
                                {
                                    image = icon,
                                    resize = true,
                                    clip_shape = helpers.rrect(
                                        beautiful.border_radius - 3),
                                    widget = wibox.widget.imagebox
                                },
                                widget = wibox.container.margin,
                                margins = 10,
                            },
                            -- bg = beautiful.xcolor1,
                            strategy = 'exact',
                            height = 40,
                            width = 40,
                            widget = wibox.container.constraint
                        },
                        layout = wibox.layout.align.vertical
                    },
                    top = dpi(13),
                    left = dpi(15),
                    right = dpi(15),
                    bottom = dpi(13),
                    widget = wibox.container.margin
                },
                {
                    {
                        nil,
                        {
                            {
                                {
                                    step_function = wibox.container.scroll
                                        .step_functions
                                        .waiting_nonlinear_back_and_forth,
                                    speed = 50,
                                    {
                                        markup = "<b>" .. title .. "</b>",
                                        font = beautiful.font,
                                        align = "left",
                                        widget = wibox.widget.textbox
                                    },
                                    forced_width = dpi(204),
                                    widget = wibox.container.scroll.horizontal
                                },
                                {
                                    {
                                        markup = time,
                                        align = "right",
                                        font = beautiful.font,
                                        widget = wibox.widget.textbox
                                    },
                                    left = dpi(30),
                                    widget = wibox.container.margin
                                },
                                -- {
                                --     {
                                --         dismiss,
                                --         halign = "right",
                                --         widget = wibox.container.place
                                --     },
                                --     left = dpi(10),
                                --     widget = wibox.container.margin
                                -- },
                                layout = wibox.layout.fixed.horizontal
                            },
                            {
                                markup = message,
                                align = "left",
                                font = beautiful.font,
                                widget = wibox.widget.textbox
                            },
                            layout = wibox.layout.fixed.vertical
                        },
                        nil,
                        expand = "none",
                        layout = wibox.layout.align.vertical
                    },
                    margins = dpi(8),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.align.horizontal
            },
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin
        },
        bg = bg .. "55",
        shape = helpers.rrect(beautiful.border_radius),
        widget = wibox.container.background
    }

    return box
end

return todobox



