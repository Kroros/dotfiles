local wallpaperDir = "/home/david/hdd/wallpapers/"
local updateInterval = 900
local ext = require("scripts.extensions")

local wallpapers = ext.scanDir(wallpaperDir)
table.remove(wallpapers, 1)
table.remove(wallpapers, 1)

return {
	updateWallpapers = function()
		local m = #wallpapers
		local wp1 = wallpapers[math.random(m)]
		local wp2 = wallpapers[math.random(m)]
		local wp3 = wallpapers[math.random(m)]

		hl.exec_cmd("awww img --transition-type wipe --transition-angle 30 -o HDMI-A-1 " .. wp1)
		hl.exec_cmd("awww img --transition-type wipe --transition-angle 30 -o DP-1 " .. wp2)
		hl.exec_cmd("awww img --transition-type wipe --transition-angle 30 -o DP-2 " .. wp3)
	end,
}
