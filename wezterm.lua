local wezterm = require 'wezterm'
local os = require 'os'

-- get environment variable `HOME`
local home = os.getenv("HOME")

return {
    font = wezterm.font_with_fallback {
        -- my favorite fonts
        'SF Mono',
        'Menlo',
        'FirgeNerd Console',  -- https://github.com/yuru7/Firge
    },
    background = {
        {   -- base background color
            source = { Color = "black" },
            opacity = 1.0,
            width = "100%",
            height = "100%",
        },
        {
            -- my favorite background image goes here
            source = { File = home .. "/Pictures/bg.jpg" },
            opacity = 0.7,
            hsb = {
                hue = 1.0,
                saturation = 1.0,
                brightness = 0.5,
            },
            vertical_align = "Middle",
            horizontal_align = "Center",
            width = "Cover",
            height = "Cover",
        },
    },
    --text_background_opacity = 0.7,
}

