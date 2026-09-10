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

-- fn({[OS]: T}) -> T
local match_os = (function()
    local key -- string
    if string.match(wezterm.target_triple, "apple") then
        key = "macos"
    elseif string.match(wezterm.target_triple, "windows") then
        key = "windows"
    else
        key = "linux"
    end
    return function(cases)
        return cases[key]
    end
end)()

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
        home .. "/.bg.png",
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

-- fn(partial<WezTermConfig>) -> WezTermConfig
local function config_with(overrides)
    local config --[[WezTermConfig]] = wezterm.config_builder()
    for k, v in pairs(overrides) do
        config[k] = v
    end
    return config
end

local blur_key --[[string]] = match_os {
    macos = "macos_window_background_blur",
    windows = "win32_system_backdrop",
    linux = "wayland_window_background_blur",
}

return config_with {
    font = make_font(),
    font_size = 13.0,
    background = make_background(),
    window_background_opacity = 0.3,
    [blur_key] = 12,
    color_scheme = "Catppuccin Mocha",
    cell_width = 1.0,
    line_height = 1.1,
    initial_cols = 120,
    initial_rows = 36,
    tab_bar_at_bottom = true,
    window_decorations = "TITLE | RESIZE",
}
