local wezterm = require("wezterm")
local act = wezterm.action

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

return {

	-- Aesthetic
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
	}),
	-- tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	switch_to_last_active_tab_when_closing_tab = true,
	adjust_window_size_when_changing_font_size = false,

	-- Window
	window_decorations = "RESIZE",
	webgpu_power_preference = "HighPerformance",
	animation_fps = 10,
	max_fps = 120,
	disable_default_key_bindings = true,
	window_padding = {
		top = 30,
		left = 30,
		right = 30,
		bottom = 30,
	},
	window_frame = {
		font = wezterm.font({ family = "JetBrainsMono Nerd Font" }),
	},
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.7,
	},
	keys = {
		{ key = "p", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },
		{ key = "r", mods = "CMD|SHIFT", action = act.ReloadConfiguration },
		{ key = "+", mods = "CMD", action = act.IncreaseFontSize },
		{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
		{ key = "0", mods = "CMD", action = act.ResetFontSize },
		-- Tabs
		{ key = "t", mods = "CMD", action = act.SpawnTab("DefaultDomain") },
		{ key = "n", mods = "CMD", action = act.SpawnWindow },
		{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
		{ key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },

		-- Pane
		{ key = "LeftArrow", mods = "CMD|SHIFT", action = act.SplitPane({ direction = "Left" }) },
		{ key = "RightArrow", mods = "CMD|SHIFT", action = act.SplitPane({ direction = "Right" }) },
		{ key = "DownArrow", mods = "CMD|SHIFT", action = act.SplitPane({ direction = "Down" }) },
		{ key = "UpArrow", mods = "CMD|SHIFT", action = act.SplitPane({ direction = "Up" }) },
		{ key = "Enter", mods = "CMD|SHIFT", action = act.TogglePaneZoomState },

		{ key = "k", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Down") },
		{ key = "h", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CMD|SHIFT", action = act.ActivatePaneDirection("Right") },

		-- cursor movement --
		{ key = "LeftArrow", mods = "CMD", action = act.SendString("\x1bOH") },
		{ key = "RightArrow", mods = "CMD", action = act.SendString("\x1bOF") },
		{ key = "Backspace", mods = "CMD", action = act.SendString("\x15") },

		-- copy/paste --
		{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	},
	automatically_reload_config = true,
	hyperlink_rules = {
		-- Matches: a URL in parens: (URL)
		{
			regex = "\\((\\w+://\\S+)\\)",
			format = "$1",
			highlight = 1,
		},
		-- Matches: a URL in brackets: [URL]
		{
			regex = "\\[(\\w+://\\S+)\\]",
			format = "$1",
			highlight = 1,
		},
		-- Matches: a URL in curly braces: {URL}
		{
			regex = "\\{(\\w+://\\S+)\\}",
			format = "$1",
			highlight = 1,
		},
		-- Matches: a URL in angle brackets: <URL>
		{
			regex = "<(\\w+://\\S+)>",
			format = "$1",
			highlight = 1,
		},
		-- Then handle URLs not wrapped in brackets
		{
			-- Before
			--regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
			--format = '$0',
			-- After
			regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
			format = "$1",
			highlight = 1,
		},
		-- implicit mailto link
		{
			regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
			format = "mailto:$0",
		},
	},
}
