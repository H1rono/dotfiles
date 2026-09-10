local wezterm = require 'wezterm'
local os = require 'os'
local io = require 'io'

-- get environment variables
local user --[[string]] = os.getenv("USER") or "h1rono"
local home --[[string]] = os.getenv("HOME") or ("/home/" .. user)
local xdg_config_home --[[string]] = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")

-- fn(string) -> boolean
local function file_exists(name)
    local handle --[[file]] = io.open(name, "r")
    local res --[[boolean]] = handle ~= nil
    if res then
        handle:close()
    end
    return res
end

-- fn() -> wezterm.font_with_fallback
local function make_font()
    local fonts --[[array<string>]] = {
        -- my favorite fonts
        "SF Mono",
        "Menlo",
        "FirgeNerd Console",  -- https://github.com/yuru7/Firge
    }
    return wezterm.font_with_fallback(fonts)
end

-- type WezTermBackgroundLayer
-- ... https://wezterm.org/config/lua/config/background.html#layer-definition

-- fn(array<string>) -> nil | WezTermBackgroundLayer
local function bg_image(candidates)
    -- candidates is an array of background image paths
    local bg_image_path --[[nil | string]]
    for i = 1, #candidates do
        local bg_candidate --[[string]] = candidates[i]
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
        opacity = 0.32,
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
    local res --[[array<WezTermBackgroundLayer>]] = {
        {   -- base background color
            source = { Color = "#282C34" },
            opacity = 0.7,
            width = "100%",
            height = "100%",
        },
    }
    local img --[[nil | WezTermBackgroundLayer]] = bg_image {
        home .. "/Pictures/bg.png",
        home .. "/Pictures/bg.jpeg",
        home .. "/Pictures/bg.jpg",
        home .. "/bg.png",
        home .. "/.bg.jpeg",
        home .. "/.bg.jpg",
        xdg_config_home .. "/bg.png",
        xdg_config_home .. "/bg.jpeg",
        xdg_config_home .. "/bg.jpg"
    }
    if img ~= nil then
        res[2] = img
    end
    return res
end

return {
    font = make_font(),
    background = make_background(),
    hide_tab_bar_if_only_one_tab = true,
    color_scheme = "Catppuccin Mocha",
    window_decorations = "RESIZE"
}
