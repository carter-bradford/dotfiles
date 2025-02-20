local wezterm = require("wezterm")
return {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 12.0,
	font = wezterm.font("CaskaydiaCove Nerd Font Mono"),

	window_background_opacity = 0.93,
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
