local wezterm = require 'wezterm';

return {
    font_dirs = {"/home/koho/.local/share/fonts"},
    front_end = "OpenGL",
    scrollback_lines = 10000,
    font = wezterm.font("Iosevka Nerd Font", {weight = "Regular", italic = false}),
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
    font_size = 15,
    -- window_background_image = "/home/koho/.config/wezterm/bg.jpeg",
    color_scheme = 'Catppuccin',
    keys = {
        -- This will create a new split and run the `top` program inside it
        {key="ä", mods="CTRL", action=wezterm.action{SplitVertical={}}},
        {key="å", mods="CTRL", action=wezterm.action{SplitHorizontal={}}},
        {key="q", mods="CTRL", action=wezterm.action{CloseCurrentPane={confirm=true}}},
        { key = "h", mods="CTRL",
            action=wezterm.action{ActivatePaneDirection="Left"}},
        { key = "l", mods="CTRL",
            action=wezterm.action{ActivatePaneDirection="Right"}},
        { key = "k", mods="CTRL",
            action=wezterm.action{ActivatePaneDirection="Up"}},
        { key = "j", mods="CTRL",
            action=wezterm.action{ActivatePaneDirection="Down"}},
            { key = "h", mods = "ALT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
            { key = "j", mods = "ALT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
            { key = "k", mods = "ALT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
            { key = "l", mods = "ALT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
        
    },
    mouse_bindings = {
        {
          event={Up={streak=1, button="Left"}},
          mods="CTRL",
          action="OpenLinkAtMouseCursor",
        },
      },
    window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    },
    inactive_pane_hsb = {
        saturation = 0.5,
        brightness = 1.0,
        hue = 1.0,
    },
    enable_tab_bar = false,
    exit_behavior = "CloseOnCleanExit"
}
