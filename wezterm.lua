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

-- fn() -> array<string>
-- returns the sorted array of installed font names
local function installed_fonts()
    local cmd --[[string]] = "fc-list | awk -F ':' '{print $2}' | sort | uniq"
    local handle --[[file]] = io.popen(cmd)  -- I'm not sure whether this type is correct
    local cmd_res --[[string]] = handle:read("*a")
    handle:close()
    local --[[array<string>]] res = {}
    for line --[[string]] in cmd_res:gmatch("[^\n\r]*") do
        local l --[[string]] = line:gsub("^%s*(.-)%s*$", "%1")
        res[#res + 1] = l
    end
    table.sort(res, function(a, b) return a < b end)
    return res
end

-- fn(string, array<string>) -> boolean
-- judges whether the font named `font_name` exists in the array `fonts`
local function font_exists(font_name, fonts)
    -- binary search
    local ng --[[integer]], ok --[[integer]] = 0, #fonts
    while ng + 1 < ok do
        local mid --[[integer]] = (ng + ok) >> 1
        if fonts[mid] < font_name then
            ng = mid
        else
            ok = mid
        end
    end
    return fonts[ok] ~= nil and font_name == fonts[ok]
end

-- fn(nil | array<string>, array<string>) -> array<string>
local function get_font_fallback(candidates, all_fonts)
    local res --[[array<string>]] = {}
    for i --[[integer]] = 1, #candidates do
        local cand --[[string]] = candidates[i]
        if font_exists(cand, all_fonts) then
            table.insert(res, cand)
        end
    end
    return res
end

-- fn() -> wezterm.font_with_fallback
local function make_font()
    local all_fonts --[[array<string>]] = wezterm.GLOBAL.fonts or installed_fonts()
    local candidates --[[array<string>]] = {
        -- my favorite fonts
        "SF Mono",
        "Menlo",
        "FirgeNerd Console",  -- https://github.com/yuru7/Firge
    }
    local fallback --[[array<string>]] = get_font_fallback(candidates, all_fonts)
    return wezterm.font_with_fallback(fallback)
end

-- type WezTermBackgroundLayer
-- ... https://wezfurlong.org/wezterm/config/lua/config/background.html#layer-definition

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

wezterm.GLOBAL.fonts = wezterm.GLOBAL.fonts or installed_fonts()

return {
    font = make_font(),
    background = make_background()
}
