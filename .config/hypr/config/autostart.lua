local vars = require("config/localEnv")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("quickshell -p " .. vars.qsPath)
	hl.exec_cmd("otd-daemon")
	hl.exec_cmd("swaync")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("$HOME/.config/hypr/scripts/wallpapers.sh")
end)
