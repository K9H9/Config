local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- local art = wibox.widget {
--     image = gears.filesystem.get_configuration_dir() .. "images/no_music.png",
--     resize = true,
--     forced_height = dpi(100),
--     widget = wibox.widget.imagebox
-- }


-- local create_button = function(symbol, color, command, playpause)

--     local icon = wibox.widget {
--         markup = helpers.colorize_text(symbol, color),
--         font = beautiful.icon_font_name .. "12",
--         align = "center",
--         valigin = "center",
--         widget = wibox.widget.textbox()
--     }

--     local button = wibox.widget {
--         icon,
--         forced_height = dpi(15),
--         forced_width = dpi(15),
--         widget = wibox.container.background
--     }

--     awesome.connect_signal("bling::playerctl::status", function(playing)
--         if playpause then
--             if playing then
--                 icon.markup = helpers.colorize_text(" ", color)
--             else
--                 icon.markup = helpers.colorize_text(" ", color)
--             end
--         end
--     end)

--     button:buttons(gears.table.join(
--                        awful.button({}, 1, function() command() end)))

--     button:connect_signal("mouse::enter", function()
--         icon.markup = helpers.colorize_text(icon.text, beautiful.xforeground)
--     end)

--     button:connect_signal("mouse::leave", function()
--         icon.markup = helpers.colorize_text(icon.text, color)
--     end)

--     return button
-- end

-- local title_widget = wibox.widget {
--     markup = 'No Title',
--     align = 'center',
--     valign = 'center',
--     ellipsize = 'middle',
--     forced_height = dpi(12),
--     widget = wibox.widget.textbox
-- }

-- local artist_widget = wibox.widget {
--     markup = 'No Artist',
--     align = 'center',
--     valign = 'center',
--     ellipsize = 'middle',
--     forced_height = dpi(12),
--     widget = wibox.widget.textbox
-- }

-- -- Get Song Info 
-- awesome.connect_signal("bling::playerctl::title_artist_album", function(title, artist, art_path)
--     -- Set art widget
--     art:set_image(gears.surface.load_uncached(art_path))

--     title_widget:set_markup_silently(
--         '<span foreground="' .. beautiful.xcolor6 .. '">' .. title .. '</span>')
--     artist_widget:set_markup_silently(
--         '<span foreground="' .. beautiful.xcolor6 .. '">' .. artist .. '</span>')
-- end)

-- local play_command =
--     function() Playerctl:play_pause() end
-- local prev_command = function() Playerctl:previous() end
-- local next_command = function() Playerctl:next() end

-- local playerctl_play_symbol = create_button(" ", beautiful.xcolor4,
--                                             play_command, true)

-- local playerctl_prev_symbol = create_button("玲", beautiful.xcolor4,
--                                             prev_command, false)
-- local playerctl_next_symbol = create_button("怜", beautiful.xcolor4,
--                                             next_command, false)

-- local slider = wibox.widget {
--     forced_height = dpi(3),
--     bar_shape = helpers.rrect(beautiful.border_radius),
--     shape = helpers.rrect(beautiful.border_radius),
--     background_color = beautiful.xcolor0 .. 55,
--     color = beautiful.xcolor6,
--     value = 25,
--     max_value = 100,
--     widget = wibox.widget.progressbar
-- }

-- -- awesome.connect_signal("bling::playerctl::position", function(pos, length, _)
-- --     slider.value = (pos / length) * 100
-- -- end)

-- local playerctl = require("module.bling").signal.playerctl.lib()
-- playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
--     local pos_now = tostring(os.date("!%M:%S", math.floor(interval_sec)))
--     local pos_length = tostring(os.date("!%M:%S", math.floor(length_sec)))
--     local pos_markup = helpers.colorize_text(pos_now .. " / " .. pos_length, beautiful.xforeground .. "66")

--     slider.value = (pos_now / pos_length) * 100
-- end)
-- local playerctl = wibox.widget {
--     {
--         {
--             art,
--             bg = beautiful.xcolor0,
--             shape = helpers.rrect(beautiful.border_radius),
--             widget = wibox.container.background
--         },
--         left = dpi(0),
--         top = dpi(0),
--         bottom = dpi(0),
--         layout = wibox.container.margin
--     },
--     {
--         {
--             {
--                 {
--                     title_widget,
--                     artist_widget,
--                     layout = wibox.layout.fixed.vertical
--                 },
--                 top = 10,
--                 left = 25,
--                 right = 25,
--                 widget = wibox.container.margin
--             },
--             {
--                 nil,
--                 {
--                     playerctl_prev_symbol,
--                     playerctl_play_symbol,
--                     playerctl_next_symbol,
--                     spacing = dpi(40),
--                     layout = wibox.layout.fixed.horizontal
--                 },
--                 nil,
--                 expand = "none",
--                 layout = wibox.layout.align.horizontal
--             },
--             {
--                 slider,
--                 top = dpi(10),
--                 left = dpi(25),
--                 right = dpi(25),
--                 widget = wibox.container.margin
--             },
--             layout = wibox.layout.align.vertical
--         },
--         top = dpi(0),
--         bottom = dpi(10),
--         widget = wibox.container.margin
--     },
--     widget = wibox.container.background,
--     layout = wibox.layout.align.horizontal,
--     bg = beautiful.lighter_bg
-- }

-- return playerctl
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Widget library
local wibox = require("wibox")

-- Helpers
local helpers = require("helpers")


-- Music
----------

local music_text = wibox.widget{
    font = beautiful.font_name .. "medium 8",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "images/no_music.png",
    resize = true,
    widget = wibox.widget.imagebox
}

local music_art_container = wibox.widget {
    music_art,
    forced_height = dpi(120),
    forced_width = dpi(120),
    widget = wibox.container.background
}

local filter_color = {
    type = 'linear',
    from = {0, 0},
    to = {0, 200},
    stops = {{0, beautiful.darker_bg .. "cc"}, {1, beautiful.xbackground}}
}

local music_art_filter = wibox.widget {
    {
        bg = filter_color,
        forced_height = dpi(120),
        forced_width = dpi(120),
        widget = wibox.container.background
    },
    direction = "east",
    widget = wibox.container.rotate
}

local music_title = wibox.widget{
    font = beautiful.font_name .. "medium 9",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_artist = wibox.widget{
    font = beautiful.font_name .. "medium 12",
    valign = "center",
    widget = wibox.widget.textbox
}

local music_pos = wibox.widget{
    font = beautiful.font_name .. "medium 8",
    valign = "center",
    widget = wibox.widget.textbox
}


-- playerctl
---------------

local playerctl = require("module.bling").signal.playerctl.lib()

playerctl:connect_signal("metadata", function(_, title, artist, album_path, __, ___, ____)
    if title == "" then title = "Nothing Playing" end
    if artist == "" then artist = "Nothing Playing" end
    if album_path == "" then album_path = gears.filesystem.get_configuration_dir() .. "theme/assets/no_music.png" end

    music_art:set_image(gears.surface.load_uncached(album_path))
    music_title:set_markup_silently(helpers.colorize_text(title, beautiful.xforeground .. "b3"))
    music_artist:set_markup_silently(helpers.colorize_text(artist, beautiful.xforeground .. "e6"))
end)

playerctl:connect_signal("playback_status", function(_, playing, __)
    if playing then
        music_text:set_markup_silently(helpers.colorize_text("Now Playing", beautiful.xforeground .. "cc"))
    else
        music_text:set_markup_silently(helpers.colorize_text("Music", beautiful.xforeground .. "cc"))
    end
end)

playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    local pos_now = tostring(os.date("!%M:%S", math.floor(interval_sec)))
    local pos_length = tostring(os.date("!%M:%S", math.floor(length_sec)))
    local pos_markup = helpers.colorize_text(pos_now .. " / " .. pos_length, beautiful.xforeground .. "66")

    music_pos:set_markup_silently(pos_markup)
end)


local music = wibox.widget{
        {
            {
                music_art_container,
                music_art_filter,
                layout = wibox.layout.stack
            },
            {
                {
                    music_text,
                    {
                        {
                            {
                                step_function = wibox.container.scroll
                                    .step_functions
                                    .waiting_nonlinear_back_and_forth,
                                speed = 50,
                                {
                                    widget = music_artist,
                                },
                                forced_width = dpi(180),
                                widget = wibox.container.scroll.horizontal
                            },
                            {
                                step_function = wibox.container.scroll
                                    .step_functions
                                    .waiting_nonlinear_back_and_forth,
                                speed = 50,
                                {
                                    widget = music_title,
                                },
                                forced_width = dpi(180),
                                widget = wibox.container.scroll.horizontal
                            },
                            layout = wibox.layout.fixed.vertical
                        },
                        bottom = dpi(15),
                        widget = wibox.container.margin
                    },
                    music_pos,
                    expand = "none",
                    layout = wibox.layout.align.vertical
                },
                top = dpi(9),
                bottom = dpi(9),
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            layout = wibox.layout.stack
        },
        bg = beautiful.darker_bg,
        shape = helpers.rrect(dpi(5)),
        forced_width = dpi(200),
        forced_height = dpi(120),
        widget = wibox.container.background
}

return music