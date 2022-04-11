local naughty = require('naughty')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")

local empty_todobox = require('ui/todo.todocenter.todo-center.emptytodo')

local width = 50

local remove_todobox_empty = true

local todobox_layout = wibox.widget {
    layout = require("module.overflow").vertical,
    scrollbar_width = 2,
    spacing = 10,
    scroll_speed = 30
}

todobox_layout.forced_width = width

reset_todobox_layout = function()
    todobox_layout:reset(todobox_layout)
    todobox_layout:insert(1, empty_todobox)
    remove_todobox_empty = true
end

remove_todobox = function(box)
    todobox_layout:remove_widgets(box)

    if #todobox_layout.children == 0 then
        todobox_layout:insert(1, empty_todobox)
        remove_todobox_empty = true
    end
end

todobox_layout:insert(1, empty_todobox)

local emit_on_restart = function() 
    if #todobox_layout.children == 1 and remove_todobox_empty then
        todobox_layout:reset(todobox_layout)
        remove_todobox_empty = false
    end
    local appicon = beautiful.notification_icon 
    local width = 50

    local box = require("ui/todo.todocenter.todo-center.todobox")

    local pipe = io.popen'cat ~/.config/awesome/signal/awesome_utils/todo-todo.txt'
    for line in pipe:lines() do
        todobox_layout:insert(1, box.create(beautiful.cross, "Todo", line, beautiful.xcolor1 ,width))
    end
    pipe:close()
end

local emit_on_restart1 = function()
    if #todobox_layout.children == 1 and remove_todobox_empty then
        todobox_layout:reset(todobox_layout)
        remove_todobox_empty = false
    end
    local appicon = beautiful.notification_icon 
    local width = 50

    local box = require("ui.todo.todocenter.todo-center.todobox")

    local pipe = io.popen'cat ~/.config/awesome/signal/awesome_utils/todo-done.txt'
    for line in pipe:lines() do
        todobox_layout:insert(1, box.create(beautiful.yes,"Done", line, beautiful.xcolor2, width))
    end
    pipe:close()
end

--run once to initialize todo list
emit_on_restart() 
emit_on_restart1()


awesome.connect_signal("todo::todo",function() 
    if #todobox_layout.children == 1 and remove_todobox_empty then
        todobox_layout:reset(todobox_layout)
        remove_todobox_empty = false
    end
    local appicon = beautiful.notification_icon 
    local width = 50

    local box = require("ui/todo.todocenter.todo-center.todobox")

    local pipe = io.popen'cat ~/.config/awesome/signal/awesome_utils/todo-todo.txt'
    for line in pipe:lines() do
        todobox_layout:insert(1, box.create(beautiful.cross, "Todo", line, beautiful.xcolor1 ,width))
    end
    pipe:close()

end)

awesome.connect_signal("todo::done",function() 
    if #todobox_layout.children == 1 and remove_todobox_empty then
        todobox_layout:reset(todobox_layout)
        remove_todobox_empty = false
    end
    local appicon = beautiful.notification_icon 
    local width = 50

    local box = require("ui.todo.todocenter.todo-center.todobox")

    local pipe = io.popen'cat ~/.config/awesome/signal/awesome_utils/todo-done.txt'
    for line in pipe:lines() do
        todobox_layout:insert(1, box.create(beautiful.yes,"Done", line, beautiful.xcolor2, width))
    end
    pipe:close()

end)


return todobox_layout
