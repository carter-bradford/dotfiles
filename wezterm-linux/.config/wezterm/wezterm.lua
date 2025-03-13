local wezterm = require("wezterm")
return {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 12.0,
	font = wezterm.font("JetBrains Mono"),

	colors = {
		background = "#1e1e2e",
	},

	background = {
		{
			source = {
				File = "/Users/cbradford/.config/backgrounds/tokyo-night.jpg",
			},
			opacity = 1.0,
			width = "100%",
			height = "100%",
			repeat_x = "NoRepeat",
			repeat_y = "NoRepeat",
			hsb = {
				brightness = 1.0,
				hue = 1.0,
				saturation = 1.0,
			},
		},
		{
			source = {
				Color = "#1e1e2e",
			},
			width = "100%",
			height = "100%",
			opacity = 0.75,
		},
	},

	window_background_opacity = 1.0,
	--macos_window_background_blur = 20,
	--	window_decorations = "RESIZE",
	keys = {
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "'",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
