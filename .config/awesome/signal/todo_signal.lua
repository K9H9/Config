local awful = require("awful")
local naughty = require('naughty')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")



local todo_script = [[
    sh -c "
    while (inotifywait -e modify ~/.config/awesome/signal/awesome_utils/todo-todo.txt -qq) do echo; done
    "]]
local done_script = [[
    sh -c "
    while (inotifywait -e modify ~/.config/awesome/signal/awesome_utils/todo-done.txt -qq) do echo; done
    "]]



-- awesome.emit_signal("todo::todo")
-- awesome.emit_signal("todo::done")


-- Kill old inotifywait process
awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e modify ~/.config/awesome/signal/awesome_utils\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    -- Update todo status with each line printed
    awful.spawn.with_line_callback(todo_script, {
        stdout = function(_)
            _G.reset_todobox_layout()
            awesome.emit_signal("todo::todo")
        end
    })
    
    awful.spawn.with_line_callback(done_script, {
        stdout = function(_)
            awesome.emit_signal("todo::done")
        end
    })

end)