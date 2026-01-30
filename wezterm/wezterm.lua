local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- window
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- colors
config.color_scheme = "Tokyo Night"
config.window_background_gradient = {
	colors = { "#170E3D", "#540F6B" },
	orientation = { Linear = { angle = -60.0 } },
}

-- font
config.font = wezterm.font_with_fallback({
	"Berkeley Mono",
	"MonaspiceAr Nerd Font",
})
config.font_size = 19
config.line_height = 1.35

-- keyboard
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- misc
config.audible_bell = "Disabled"

return config
