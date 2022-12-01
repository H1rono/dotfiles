local wezterm = require 'wezterm'
local os = require 'os'
local io = require 'io'

-- get environment variables
local user = os.getenv("USER") or "h1rono"
local home = os.getenv("HOME") or ("/home/" .. user)
local xdg_config_home = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")

-- fn(string) -> boolean
local function file_exists(name)
    local handle = io.open(name, "r")
    local res = handle ~= nil
    if res then
        handle:close()
    end
    return res
end

-- type WezTermBackgroundLayer
-- ... https://wezfurlong.org/wezterm/config/lua/config/background.html#layer-definition

-- fn(nil | array) -> nil | WezTermBackgroundLayer
local function bg_image(candidates)
    -- candidates is an array of background image paths
    local bg_image_candidates = candidates or {
        home .. "/Pictures/bg.jpeg",
        home .. "/Pictures/bg.jpg",
        home .. "/.bg.jpeg",
        home .. "/.bg.jpg",
        xdg_config_home .. "/bg.jpeg",
        xdg_config_home .. "/bg.jpg"
    }
    local bg_image_path
    for i = 1, #bg_image_candidates do
        local bg_candidate = bg_image_candidates[i]
        if file_exists(bg_candidate) then
            bg_image_path = bg_candidate
            break
        end
    end
    if bg_image_path == nil then
        return nil
    end
    return {
        source = { File = bg_image_path },
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
    }
end

-- fn() -> array<WezTermBackgroundLayer>
local function make_background()
    local res = {
        {   -- base background color
            source = { Color = "#282C34" },
            opacity = 1.0,
            width = "100%",
            height = "100%",
        },
    }
    local img = bg_image()
    if img ~= nil then
        res[2] = img
    end
    return res
end

return {
    font = wezterm.font_with_fallback {
        -- my favorite fonts
        'SF Mono',
        'Menlo',
        'FirgeNerd Console',  -- https://github.com/yuru7/Firge
    },
    background = make_background()
}

