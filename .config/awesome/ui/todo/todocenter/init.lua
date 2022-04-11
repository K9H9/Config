local wibox = require('wibox')
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local todo_header = wibox.widget {
    markup = 'Notification Center',
    font = beautiful.font_name .. "10",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

return wibox.widget {
    require("ui.todo.todocenter.todo-clear"),
    spacing = 10,
    require('ui.todo.todocenter.todo-center'),
    margins = 20,
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}
