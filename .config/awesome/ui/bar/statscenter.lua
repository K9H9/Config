local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")
local buttons = require "ui.buttons"
local todo = require("ui.widgets.todow")


local app_factory = function(icon, exec, margins)
	return buttons.make_button {
		icon = icon,
		bg = beautiful.darker_bg,
		hover = true,
		width = 80,
		height = 80,
		margins = margins,
		exec = function()
			awful.spawn(exec)
		end,
	}
end

local app_gimp = app_factory(beautiful.gimp, "gimp", 20)
local app_discord = app_factory(beautiful.discord,"discord", 20)
local site_gmail = app_factory(beautiful.gmail,"brave https://mail.google.com", 20)
local site_github = app_factory(beautiful.github, "brave https://github.com", 20)
local app_code = app_factory(beautiful.vscode,"code", 20)
local app_brave = app_factory(beautiful.brave,"brave", 20)
local app_terminal = app_factory(beautiful.spotify,"spotify", 20)
local site_artix = app_factory(beautiful.distro_logo, "brave https://wiki.archlinux.org/", 20)


local apps = wibox.widget {
	layout = wibox.layout.grid,
	spacing = 8,
	forced_num_cols = 4,
	forced_num_rows = 2,
	app_gimp,
	app_brave,
	site_github,
	app_code,
	app_discord,
	site_gmail,
	app_terminal,
	site_artix
}


local box_todo = wibox.widget {
	{
			{
					todo,
					top = dpi(9),
					bottom = dpi(9),
					left = dpi(10),
					right = dpi(10),
					widget = wibox.container.margin
			},
			widget = wibox.container.background,
	},
	margins = dpi(10),
	widget = wibox.container.margin
}

local calendar = wibox.widget {
	widget = wibox.container.background,
	bg = beautiful.darker_bg,
	forced_width = 100,
	forced_height = 100,
	{
		widget = wibox.container.margin,
		top = 25,
		bottom = 20,
		left = 3,
		rigth = 9,
		{
			layout = wibox.layout.fixed.vertical,
			{
				widget = wibox.widget.textclock "%A",
				font = beautiful.font_name .. " Bold 9",
				align = "center",
			},
			{
				widget = wibox.widget.textclock(helpers.colorize_text("%d", beautiful.xcolor4)),
				font = beautiful.font_name .. " Bold 30",
				align = "center",
			},
			{
				widget = wibox.widget.textclock "%b",
				font = beautiful.font_name .. "Bold 12",
				align = "center",
			},
		},
	},
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 6)
	end,
}

awful.screen.connect_for_each_screen(function(s)
	local slide_button = wibox.widget { 
		{
			id = "slide_left_button",
			widget = wibox.widget.imagebox,
			image = gears.color.recolor_image("/home/koho/Downloads/arrow.svg", beautiful.lighter_bg),
			forced_width = 50,
			halign = "center",
			align = "center", 
			valign = "center",
		},
		bg = beautiful.darker_bg,
		widget = wibox.container.margin,
		margins = 10,
	}
	local t = true
	slide_button:buttons {
		awful.button({}, 1, function()
			awesome.emit_signal("slide_left::open")
			t = not t
			if t then
				slide_button.slide_left_button.image = gears.color.recolor_image("/home/koho/Downloads/arrow.svg", beautiful.lighter_bg)
			else
				slide_button.slide_left_button.image = gears.color.recolor_image("/home/koho/Downloads/arrow-right.svg", beautiful.lighter_bg)
			end
		end)
		}
	s.todo_tooltip = wibox{
				type = "desktop", 
				ontop = true,
				screen = screen.primary, 
				x = 1920 - (beautiful.panel_width)-dpi(25) - 50,
				y = -dpi(500),
				width = beautiful.panel_width + 50,
				height = dpi(450),
				visible = true
	}
			
	s.todo_tooltip.widget = wibox.widget {
				{
					{
						{
							slide_button,
							widget = wibox.container.background,
							bg = beautiful.xbackground,
							forced_height = dpi(450),
							forced_width = 50,
						},
						layout = wibox.layout.align.vertical,
					},	
					{
						{
							{
								require("ui.todo.todocenter"),
								forced_height = 750,
								widget = wibox.container.constraint
							},
							widget = wibox.container.margin, 
							margins = 15, 
						},
						layout = wibox.layout.fixed.vertical,
					},
					{
						widget = wibox.container.background,
						bg = beautiful.darker_bg,
						forced_height = dpi(450),
						forced_width = 30,
					},
					layout = wibox.layout.align.horizontal
				},
				bg = beautiful.darker_bg,
				widget = wibox.container.background,
	}
			
	local todo_slide = rubato.timed {
				intro = 0.3,
				duration = 0.6,
				easing = rubato.quadratic,
				subscribed = function(pos)
					s.todo_tooltip.y = pos 
				end
	}
	awesome.connect_signal("popup::open", function()
			if s.todo_tooltip.y == -dpi(500) then
				todo_slide.target = 0 +dpi(25)
			else
				todo_slide.target = -dpi(500)
			end
	end)
		
		
		
	local todo_slide_left = rubato.timed {
			intro = 0.3,
			duration = 0.6,
			easing = rubato.quadratic,
			subscribed = function(pos1)
				s.todo_tooltip.x = pos1
			end
	}
		
	awesome.connect_signal("slide_left::open", function()
			if s.todo_tooltip.x == 1920 - (beautiful.panel_width)-dpi(25) - 50 then
				todo_slide_left.target = 1920 - (beautiful.panel_width) - dpi(25) - 50 - beautiful.panel_width + dpi(10) 
			else
				todo_slide_left.target = 1920 - (beautiful.panel_width)-dpi(25) - 50
			end
	end)
		
	s.mypopup = wibox({
					screen = screen.primary,
					type = "popup",
					ontop = true,
					x = 1920 - (beautiful.panel_width)-dpi(25),
					y = -dpi(500),
					width = beautiful.panel_width,
					height = dpi(450),
					visible = true
	})
	
	s.mypopup.widget = wibox.widget {
					{
							{
								{
									apps,
									calendar,
									layout = wibox.layout.fixed.horizontal,
									spacing = 30,
								},
								{
									{
										{
											box_todo,
											widget = wibox.container.background,
											bg = beautiful.darker_bg,
											shape = function(cr, width, height)
												gears.shape.rounded_rect(cr, width, height, 6)
											end,
											forced_height = 200,
											forced_width = 200,
										},
										spacing = 15,
										{
											widget = wibox.container.background,
											bg = beautiful.darker_bg,
											shape = function(cr, width, height)
												gears.shape.rounded_rect(cr, width, height, 6)
											end,
											forced_height = 200,
											forced_width = 200,
										},
										layout = wibox.layout.fixed.vertical,
									},
									spacing = 30,
									{
										require("ui.widgets.playerctl"),
										spacing = 15,
										{
											widget = wibox.container.background,
											bg = beautiful.darker_bg,
											shape = function(cr, width, height)
												gears.shape.rounded_rect(cr, width, height, 6)
											end,
											forced_height = 200,
											forced_width = 250,
										},
										layout = wibox.layout.fixed.vertical,
									},
									layout = wibox.layout.fixed.horizontal,
								},
								layout = wibox.layout.fixed.vertical,
								spacing = 20,
							},
							widget = wibox.container.margin,
							margins = 20,
						},
					bg = beautiful.xbackground,
					widget = wibox.container.background
	}
	
		local popup_timed = rubato.timed {
					intro = 0.3,
					duration = 0.6,
					easing = rubato.quadratic,
					subscribed = function(pos)
							s.mypopup.y = pos 
					end
		}
		awesome.connect_signal("popup::open", function()
					if s.mypopup.y == -dpi(500) then
							popup_timed.target = 0 +dpi(25)
							-- awesome.emit_signal("todo::open")
					else
							popup_timed.target = -dpi(500)
							-- awesome.emit_signal("todo::close")
					end
		end)
end)
	