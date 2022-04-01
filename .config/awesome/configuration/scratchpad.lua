local bling = require("module.bling")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local rubato = require("module.rubato")

local music_anim = {
    y = rubato.timed {
        pos = 1060,
        rate = 120,
        easing = rubato.quadratic,
        intro = 0.1,
        duration = 0.3,
        awestore_compat = true
    }
}

local music_scratch = bling.module.scratchpad:new{
    command = "Spotify",
    rule = {
        class = "Spotify"
    },
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = beautiful.wibar_width + dpi(10), y = dpi(10), height = 1060, width = 1920 - beautiful.wibar_width - dpi(20)},
    reapply = true,
    rubato = music_anim
}

awesome.connect_signal("scratch::music", function() music_scratch:toggle() end)

local chat_anim = {
    y = rubato.timed {
        pos = 1060,
        rate = 120,
        easing = rubato.quadratic,
        intro = 0.1,
        duration = 0.3,
        awestore_compat = true
    }
}

local chat_scratch = bling.module.scratchpad:new{
    -- command = [[ firefox -P chat --new-tab -url https://discord.com/channels/@me --class chat ]],
    command = "Discord",
    rule = {
        -- class = "chat"
        class = "discord"
    },
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = beautiful.wibar_width + dpi(10), y = dpi(10), height = 1060, width = 1920 - beautiful.wibar_width - dpi(20)},
    reapply = true,
    rubato = chat_anim
}

awesome.connect_signal("scratch::chat", function() chat_scratch:toggle() end)
