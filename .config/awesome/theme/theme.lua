local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local helpers = require("helpers")

local theme = dofile(themes_path .. "default/theme.lua")

-- Titlebar icon path
local icon_path = gfs.get_configuration_dir() .. "icons/"

-- PFP
theme.xbackground = xrdb.background
theme.xforeground = xrdb.foreground
theme.xcolor0 = xrdb.color0
theme.xcolor1 = xrdb.color1
theme.xcolor2 = xrdb.color2
theme.xcolor3 = xrdb.color3
theme.xcolor4 = xrdb.color4
theme.xcolor5 = xrdb.color5
theme.xcolor6 = xrdb.color6
theme.xcolor7 = xrdb.color7
theme.xcolor8 = xrdb.color8
theme.xcolor9 = xrdb.color9
theme.xcolor10 = xrdb.color10
theme.xcolor11 = xrdb.color11
theme.xcolor12 = xrdb.color12
theme.xcolor13 = xrdb.color13
theme.xcolor14 = xrdb.color14
theme.xcolor15 = xrdb.color15

theme.darker_bg = xrdb.color11
theme.lighter_bg = xrdb.color10
theme.bg_accent = xrdb.color2
theme.transparent = "#00000000"

-- Distro Logo
theme.titlebar_close_button_focus  = gfs.get_configuration_dir() .. "icons/close_focus.png"
theme.titlebar_close_button_normal = gfs.get_configuration_dir() .. "icons/close_normal.png"

--App/sites logos

theme.gimp = gfs.get_configuration_dir() .. "icons/gimp.svg"
theme.gimp = gears.color.recolor_image(theme.gimp, xrdb.color7)

theme.discord = gfs.get_configuration_dir() .. "icons/discord.svg"
theme.discord = gears.color.recolor_image(theme.discord, xrdb.color7)

theme.github = gfs.get_configuration_dir() .. "icons/github.svg"
theme.github = gears.color.recolor_image(theme.github, xrdb.color7)

theme.gmail = gfs.get_configuration_dir() .. "icons/gmail.svg"
theme.gmail = gears.color.recolor_image(theme.gmail, xrdb.color7)

theme.vscode = gfs.get_configuration_dir() .. "icons/vscode.svg"
theme.vscode = gears.color.recolor_image(theme.vscode, xrdb.color7)

theme.spotify = gfs.get_configuration_dir() .. "icons/spotify.svg"
theme.spotify = gears.color.recolor_image(theme.spotify, xrdb.color7)

theme.brave = gfs.get_configuration_dir() .. "icons/brave.svg"
theme.brave = gears.color.recolor_image(theme.brave, xrdb.color7)

theme.distro_logo = gfs.get_configuration_dir() .. "icons/logo.svg"
theme.distro_logo = gears.color.recolor_image(theme.distro_logo, xrdb.foreground)

theme.distro_image = gfs.get_configuration_dir() .. "icons/logo-gray-4096x4096.png"
theme.distro_image = gears.color.recolor_image(theme.distro_image, theme.lighter_bg)


-- Powermenu icons
--
theme.shutdown = gfs.get_configuration_dir() .. "icons/poweroff.svg"
theme.shutdown = gears.color.recolor_image(theme.shutdown, xrdb.foreground)
theme.logout = gfs.get_configuration_dir() .. "icons/logout.svg"
theme.logout = gears.color.recolor_image(theme.logout, xrdb.foreground)
theme.lock = gfs.get_configuration_dir() .. "icons/lock.svg"
theme.lock = gears.color.recolor_image(theme.lock, xrdb.foreground)

theme.yes = gfs.get_configuration_dir() .. "icons/yes.svg"
theme.yes = gears.color.recolor_image(theme.yes, xrdb.foreground)

theme.cross = gfs.get_configuration_dir() .. "icons/cross.svg"
theme.cross = gears.color.recolor_image(theme.cross, xrdb.foreground)




-- Icons for Notif Center and Menu
--
theme.dark = gfs.get_configuration_dir() .. "icons/moon.svg"

theme.light = gfs.get_configuration_dir() .. "icons/sun.svg"

theme.menu_icon = gfs.get_configuration_dir() .. "icons/menu.svg"
theme.menu_icon = gears.color.recolor_image(theme.menu_icon, xrdb.foreground)
theme.clear_icon = icon_path .. "notif-center/clear.png"
theme.clear_grey_icon = icon_path .. "notif-center/clear_grey.png"
theme.notification_icon = icon_path .. "notif-center/notification.png"
theme.delete_icon = icon_path .. "notif-center/delete.png"
theme.delete_grey_icon = icon_path .. "notif-center/delete_grey.png"

--control widgets and icons for them
--

theme.button_hover = "#655c54"
theme.updates = xrdb.color7
theme.no_updates = theme.lighter_bg
theme.bg_bluetooth_on = xrdb.color7
theme.bg_bluetooth_off = theme.lighter_bg
theme.wifi_on = xrdb.color7
theme.wifi_off = theme.lighter_bg
theme.bluetooth_icon = gfs.get_configuration_dir() .. "icons/bluetooth.svg"
theme.wifi_icon = gfs.get_configuration_dir() .. "icons/wifi.svg"
theme.refresh_icon = gfs.get_configuration_dir() .. "icons/refresh-svgrepo-com.svg"
theme.volume_icon = gfs.get_configuration_dir() .. "icons/volume.svg"
theme.brightness_icon = gfs.get_configuration_dir() .. "icons/sun.svg"
theme.battery_icon = gfs.get_configuration_dir() .. "icons/battery-three-quarters-solid.svg"
theme.battery_icon = gears.color.recolor_image(theme.battery_icon, "#458588")


-- Fonts
--
theme.font_name = "Iosevka Nerd Font "
theme.font = theme.font_name .. "8"
theme.icon_font_name = "Iosevka Nerd Font "
theme.icon_font = theme.icon_font_name .. "18"
theme.font_taglist = theme.icon_font_name .. "13"

-- Background Colors
--
theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.lighter_bg
theme.bg_focus = theme.xcolor0
theme.bg_urgent = theme.xcolor8
theme.bg_minimize = theme.xcolor8

-- Foreground Colors
--
theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor8

theme.button_close = theme.xcolor1


-- Tooltips
--
theme.tooltip_bg = theme.xbackground
theme.tooltip_height = dpi(245)
theme.tooltip_width = dpi(200)
theme.tooltip_gap = dpi(10)
theme.tooltip_box_margin = dpi(10)
theme.tooltip_border_radius = theme.border_radius
theme.tooltip_box_border_radius = theme.bar_radius

-- Borders
--
theme.border_width = dpi(0)
theme.oof_border_width = dpi(0)
theme.border_normal = theme.darker_bg
theme.border_focus = theme.darker_bg
theme.border_radius = dpi(6)
theme.client_radius = dpi(12)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.darker_bg

-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.lighter_bg
theme.taglist_fg_focus = theme.xcolor3
theme.taglist_bg_urgent = theme.wibar_bg
theme.taglist_fg_urgent = theme.xcolor6
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.xcolor6
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.xcolor8
theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true

theme.taglist_shape_focus = helpers.rrect(theme.border_radius)
theme.taglist_shape_empty = helpers.rrect(theme.border_radius)
theme.taglist_shape = helpers.rrect(theme.border_radius)
theme.taglist_shape_urgent = helpers.rrect(theme.border_radius)
theme.taglist_shape_volatile = helpers.rrect(theme.border_radius)

-- Wallpaper
--

theme.wallpaper = gfs.get_configuration_dir() .. "images/evening.png"

-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.lighter_bg
theme.tasklist_fg_focus = theme.xcolor6
theme.tasklist_bg_minimize = theme.xcolor0 .. 55
theme.tasklist_fg_minimize = theme.xforeground .. 55
theme.tasklist_bg_normal = theme.darker_bg
theme.tasklist_fg_normal = theme.xforeground
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_bg_urgent = theme.xcolor0
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_align = "center"

-- Titlebars
--
theme.titlebar_size = dpi(50)
theme.titlebar_bg_focus = theme.darker_bg
theme.titlebar_bg_normal = theme.darker_bg
theme.titlebar_fg_normal = theme.xcolor15 .. "80"
theme.titlebar_fg_focus = theme.xcolor15

-- Edge snap
--
theme.snap_bg = theme.xcolor8
theme.snap_shape = helpers.rrect(0)

-- Prompts
--
theme.prompt_bg = transparent
theme.prompt_fg = theme.xforeground

-- Tooltips
--
theme.tooltip_bg = theme.darker_bg
theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font_name .. "8"
theme.tooltip_border_width = 0
theme.tooltip_opacity = 1
theme.tooltip_align = "top"

-- Menu
--
theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4 .. 70
theme.menu_fg_focus = theme.xcolor7
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() ..
                              "theme/icons/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = theme.xcolor8
theme.menu_border_width = theme.border_width / 2

-- Hotkeys Pop Up
--
theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.darker_bg
theme.hotkeys_group_margin = dpi(40)
theme.hotkeys_shape = helpers.rrect(5)

-- Layout List
--
theme.layoutlist_border_color = theme.xcolor8
theme.layoutlist_border_width = theme.border_width
theme.layoutlist_shape_selected = gears.shape.squircle
theme.layoutlist_bg_selected = theme.xcolor8 .. 55

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xforeground)

-- Gaps
--
theme.useless_gap = dpi(7)

-- Exit Screen
--
theme.exit_screen_fg = theme.xforeground
theme.exit_screen_bg = theme.xcolor0 .. "80"

-- Wibar
--
theme.wibar_height = (dpi(42) + theme.widget_border_width) * 0
theme.wibar_width = dpi(42) + theme.widget_border_width
theme.panel_width = dpi(400)
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = theme.darker_bg
theme.wibar_bg_secondary = theme.xbackground
theme.wibar_position = "left"

-- Systray
--
theme.systray_icon_spacing = dpi(1)
theme.bg_systray = theme.darker_bg
theme.systray_icon_size = dpi(15)

-- Collision
--
theme.collision_focus_bg = theme.xcolor8
theme.collision_focus_fg = theme.xcolor6
theme.collision_focus_shape = helpers.rrect(theme.border_radius)
theme.collision_focus_border_width = theme.border_width
theme.collision_focus_border_color = theme.border_normal

theme.collision_focus_bg_center = theme.xcolor8
theme.collision_shape_width = dpi(50)
theme.collision_shape_height = dpi(50)
theme.collision_focus_shape_center = gears.shape.circle

theme.collision_max_bg = theme.xbackground
theme.collision_max_fg = theme.xcolor8
theme.collision_max_shape = helpers.rrect(0)
theme.bg_urgent = theme.xcolor1

theme.collision_resize_width = dpi(20)
theme.collision_resize_shape = theme.collision_focus_shape
theme.collision_resize_border_width = theme.collision_focus_border_width
theme.collision_resize_border_color = theme.collision_focus_border_color
theme.collision_resize_padding = dpi(5)
theme.collision_resize_bg = theme.collision_focus_bg
theme.collision_resize_fg = theme.collision_focus_fg

theme.collision_screen_shape = theme.collision_focus_shape
theme.collision_screen_border_width = theme.collision_focus_border_width
theme.collision_screen_border_color = theme.collision_focus_border_color
theme.collision_screen_padding = dpi(5)
theme.collision_screen_bg = theme.xbackground
theme.collision_screen_fg = theme.xcolor4
theme.collision_screen_bg_focus = theme.xcolor8
theme.collision_screen_fg_focus = theme.xcolor4

-- Tabs
--
theme.mstab_bar_height = dpi(60)
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = dpi(6)
theme.tabbar_disable = true
theme.tabbar_style = "modern"
theme.tabbar_bg_focus = theme.xbackground
theme.tabbar_bg_normal = theme.xcolor0
theme.tabbar_fg_focus = theme.xcolor0
theme.tabbar_fg_normal = theme.xcolor15
theme.tabbar_position = "bottom"
theme.tabbar_AA_radius = 0
theme.tabbar_size = 40
theme.mstab_bar_ontop = true

theme.notification_spacing = 19
theme.notification_border_radius = dpi(6)
theme.notification_border_width = dpi(0)

-- Swallowing
--
theme.dont_swallow_classname_list = {
    "firefox", "gimp", "Google-chrome", "Thunar"
}

-- Calendar
--
theme.calendar_start_sunday = true

-- Layout Machi
--
theme.machi_switcher_border_color = theme.xcolor4
theme.machi_switcher_border_opacity = 0.25
theme.machi_editor_border_color = theme.xcolor1
theme.machi_editor_border_opacity = 0.25
theme.machi_editor_active_opacity = 0.25

-- Tag Preview
--
theme.tag_preview_widget_border_radius = theme.border_radius
theme.tag_preview_client_border_radius = theme.border_radius * 0.75
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.xcolor0
theme.tag_preview_client_border_color = theme.xcolor8
theme.tag_preview_client_border_width = theme.widget_border_width
theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.widget_border_color
theme.tag_preview_widget_border_width = theme.widget_border_width * 0
theme.tag_preview_widget_margin = dpi(10)

-- Task Preview
--
theme.task_preview_widget_border_radius = theme.border_radius
theme.task_preview_widget_bg = theme.xbackground
theme.task_preview_widget_border_color = theme.widget_border_color
theme.task_preview_widget_border_width = theme.widget_border_width * 0
theme.task_preview_widget_margin = dpi(15)

theme.fade_duration = 250

return theme