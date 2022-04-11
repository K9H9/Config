local awful = require "awful"
local buttons = require "ui.buttons"

F.run = {}

local prompt = awful.widget.prompt {
  prompt = "Run: ",
  done_callback = function()
    F.run.close()
  end,
}

local prompt_widget = buttons.make_prompt_widget(prompt)

function F.run.open()
  prompt_widget.visible = true
  prompt:run()
end

function F.run.close()
  prompt_widget.visible = false
end