------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "DP-1",
	mode = "1920x1080@165",
	position = "0x0",
	scale = 1.0,
	-- until I replace it
	reserved_area = {
		top = 0,
		bottom = 50,
		left = 0,
		right = 0,
	},
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "-1920x0",
	scale = 1.0,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "1920x0",
	scale = 1.0,
})
