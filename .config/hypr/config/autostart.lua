-------------------
---- AUTOSTART ----
-------------------

local vars = require("config/localEnv")
local wpTimer = hl.timer(function()
	require("scripts.wallpapers").updateWallpapers()
end, { timeout = 900, type = "repeat" })

hl.on("hyprland.start", function()
	hl.exec_cmd("quickshell -p " .. vars.qsPath)
	hl.exec_cmd("otd-daemon")
	hl.exec_cmd("swaync")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("systemctl --user start hyprland-session.target")

	wpTimer:set_enabled(false)
end)

hl.on("hyprland.shutdown", function()
	os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
