--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.workspace_rule({
	workspace = "1",
	monitor = "DP-1",
})
hl.workspace_rule({
	workspace = "2",
	monitor = "DP-2",
	layout = "scrolling",
})
hl.workspace_rule({
	workspace = "3",
	monitor = "HDMI-A-1",
})
hl.workspace_rule({
	workspace = "5",
	layout = "scrolling",
})
hl.workspace_rule({
	workspace = "6",
	monitor = "DP-1",
})

hl.window_rule({
	name = "browser-workspace",
	match = {
		class = "^(zen)$",
	},
	workspace = 1,
})
hl.window_rule({
	name = "discord-workspace",
	match = {
		class = "^(discord)$",
	},
	workspace = 2,
})
hl.window_rule({
	name = "wa-workspace",
	match = {
		class = "^(Ferdium)$",
	},
	workspace = 2,
})
hl.window_rule({
	name = "spotify-workspace",
	match = {
		class = "^(Spotify)$",
	},
	workspace = 3,
})
hl.window_rule({
	name = "gimp-workspace",
	match = {
		class = "^(gimp)$",
	},
	workspace = 5,
})
hl.window_rule({
	name = "inkscape-workspace",
	match = {
		class = "^(Inkscape)$",
	},
	workspace = 5,
})
hl.window_rule({
	name = "blender-workspace",
	match = {
		class = "^(Blender)$",
	},
	workspace = 5,
})
hl.window_rule({
	name = "lmms-workspace",
	match = {
		class = "^(lmms)$",
	},
	workspace = 5,
})
hl.window_rule({
	name = "godot-workspace",
	match = {
		class = "^(Godot)$",
	},
	workspace = 5,
})
hl.window_rule({
	name = "steam-workspace",
	match = {
		class = "^(steam)$",
	},
	workspace = 6,
})
