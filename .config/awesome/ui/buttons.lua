local awful = require "awful"
local beautiful = require "beautiful"
local icons_dir = require("gears").filesystem.get_configuration_dir() .. "/icons/"
local wibox = require "wibox"
local gears = require "gears"
 

local M = {}

function M.make_button(opts)
  opts = opts or {}

  local icon = gears.color.recolor_image(opts.icon, opts.alt_color or beautiful.xcolor7)
  -- local icon1 = gears.color.recolor_image(opts.icon, beautiful.xcolor1)
  local icon_widget = wibox.widget {
    widget = wibox.widget.imagebox,
    image = icon,
    -- stylesheet = " * { stroke: " .. beautiful.xcolor4 .. " }",
  }

  local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    markup = opts.text or "Button",
    font = opts.font or beautiful.font,
  }

  local inner_widget = text_widget

  if opts.icon then
    inner_widget = icon_widget
  end

  local button = wibox.widget {
    widget = wibox.container.background,
    forced_width = opts.width or 100,
    forced_height = opts.height or 100,
    bg = opts.bg or beautiful.bg_normal,
    fg = opts.fg or beautiful.fg_normal,
    {
      id = "inner", 
      widget = wibox.container.margin,
      margins = opts.margins or 30,
      inner_widget,
    },
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 6)
    end,
    buttons = {
      awful.button({}, 1, function()
        opts.exec()
      end),
    },
  }

  if opts.hover then
    button:connect_signal("mouse::enter", function()
      -- icon_widget.image = icon1
      button.inner.margins = opts.margins * 0.85
    end)
    
    button:connect_signal("mouse::leave", function()
      -- icon_widget.image = icon
      button.inner.margins = opts.margins 
    end)
  end

  return button
end
function M.yesno_button(opts)
  opts = opts or {}

  local icon = gears.color.recolor_image(opts.icon, beautiful.xcolor7)
  local icon1 = gears.color.recolor_image(opts.icon, opts.alt_color)
  local icon_widget = wibox.widget {
    widget = wibox.widget.imagebox,
    image = icon,
    -- stylesheet = " * { stroke: " .. beautiful.xcolor4 .. " }",
  }

  local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    markup = opts.text or "Button",
    font = opts.font or beautiful.font,
  }

  local inner_widget = text_widget

  if opts.icon then
    inner_widget = icon_widget
  end

  local button = wibox.widget {
    widget = wibox.container.background,
    forced_width = opts.width or 100,
    forced_height = opts.height or 100,
    bg = opts.bg or beautiful.bg_normal,
    fg = opts.fg or beautiful.fg_normal,
    {
      id = "inner", 
      widget = wibox.container.margin,
      margins = opts.margins or 30,
      inner_widget,
    },
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 6)
    end,
    buttons = {
      awful.button({}, 1, function()
        opts.exec()
      end),
    },
  }

  if opts.hover then
    button:connect_signal("mouse::enter", function()
      icon_widget.image = icon1
      button.inner.margins = opts.margins * 0.85
    end)
    
    button:connect_signal("mouse::leave", function()
      icon_widget.image = icon
      button.inner.margins = opts.margins 
    end)
  end

  return button
end

function M.prompt_button(opts)
  opts = opts or {}

  local icon = gears.color.recolor_image(opts.icon, opts.alt_color or beautiful.xcolor7)
  -- local icon1 = gears.color.recolor_image(opts.icon, beautiful.xcolor1)
  local icon_widget = wibox.widget {
    widget = wibox.widget.imagebox,
    image = icon,
    -- stylesheet = " * { stroke: " .. beautiful.xcolor4 .. " }",
  }

  local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    markup = opts.text or "Button",
    font = opts.font or beautiful.font,
  }

  local inner_widget = text_widget

  if opts.icon then
    inner_widget = icon_widget
  end

  local button = wibox.widget {
    widget = wibox.container.background,
    forced_width = opts.width or 100,
    forced_height = opts.height or 100,
    bg = opts.bg or beautiful.bg_normal,
    fg = opts.fg or beautiful.fg_normal,
    {
      id = "inner", 
      widget = wibox.container.margin,
      margins = opts.margins or 30,
      inner_widget,
    },
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 6)
    end,
    buttons = {
      awful.button({}, 1, function()
        opts.exec()
      end),
    },
  }

  if opts.hover then
    button:connect_signal("mouse::enter", function()
      -- icon_widget.image = icon1
      button.inner.margins = opts.margins * 0.85
    end)
    
    button:connect_signal("mouse::leave", function()
      -- icon_widget.image = icon
      button.inner.margins = opts.margins 
    end)
  end

  return button
end


function M.make_switch(opts)
  opts = opts or {}

  local icon = opts.icon or "default"
  local icon_color = opts.icon_fg or beautiful.fg_normal
  local icon_widget = wibox.widget {
    widget = wibox.widget.imagebox,
    image = icons_dir .. icon .. ".svg",
    stylesheet = " * { stroke: " .. icon_color .. " }",
  }

  local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = opts.text or "Button",
    font = opts.font or beautiful.font,
  }

  local inner_widget = text_widget

  if opts.icon then
    inner_widget = icon_widget
  end

  local button = wibox.widget {
    widget = wibox.container.background,
    forced_width = opts.width or 100,
    forced_height = opts.height or 100,
    bg = opts.bg or beautiful.bg_normal,
    fg = opts.fg or beautiful.fg_normal,
    {
      widget = wibox.container.margin,
      margins = opts.margins or 30,
      inner_widget,
    },
  }

  local s = true
  button:buttons {
    awful.button({}, 1, function()
      s = not s
      if s then
        button.bg = opts.bg_off or beautiful.bg_normal
        opts.exec_off()
      else
        button.bg = opts.bg_on or beautiful.bg_focus
        opts.exec_on()
      end
    end),
  }

  return button
end

function M.make_prompt_widget(prompt, opts)
  opts = opts or {}
  return awful.popup {
    widget = {
      widget = wibox.container.margin,
      margins = opts.margins or 20,
      prompt,
    },
    ontop = true,
    placement = opts.placement or awful.placement.centered,
    visible = false,
    border_color = opts.border_color or beautiful.border_color_active,
    border_width = opts.border_width or 2,
    bg = opts.bg or beautiful.bg_normal,
    forced_width = opts.forced_width or 500,
    forced_height = opts.forced_height or 500,
  }
end
local function get_permission()


end
return M