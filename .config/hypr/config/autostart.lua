-------------------
---- AUTOSTART ----
-------------------

local vars = require("config/localEnv")
local wpTimer = hl.timer(function()
	require("scripts.wallpapers").updateWallpapers()
end, { timeout = 10, type = "repeat" })

hl.on("hyprland.start", function()
	hl.exec_cmd("quickshell -p " .. vars.qsPath)
	hl.exec_cmd("otd-daemon")
	hl.exec_cmd("swaync")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("awww-daemon")

	hl.exec_cmd("sleep 2 && hyprctl reload")
	wpTimer:set_enabled(true)
end)
