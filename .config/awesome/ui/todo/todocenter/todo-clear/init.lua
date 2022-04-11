local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local button = require("ui.widgets.button")
local dpi = require('beautiful').xresources.apply_dpi

local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'notifs/notif-center/icons/'

local delete_button = button.create_text(
    beautiful.lighter_bg,
    beautiful.xforeground,
    "Clear",
    beautiful.font_name .. "10",
    function()
        _G.reset_todobox_layout()
        awful.spawn.with_shell("todo rm 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20")
        awful.spawn.with_shell("truncate -s 0 ~/.config/awesome/signal/awesome_utils/todo-done.txt")
        awful.spawn.with_shell("truncate -s 0 ~/.config/awesome/signal/awesome_utils/todo-todo.txt")
        -- awful.spawn.with_shell("sed -i 'd' ~/.config/awesome/signal/awesome_utils/todo-done.txt")
        -- awful.spawn.with_shell("sed -i 'd' ~/.config/awesome/signal/awesome_utils/todo-todo.txt")   
        awesome.emit_signal("todo::done")
        awesome.emit_signal("todo::todo")
end)

local delete_button_wrapped = wibox.widget {
    {
        delete_button,
        layout = wibox.layout.align.vertical
    }, 
    widget = wibox.container.margin,
    margins = 14
}

return delete_button_wrapped
