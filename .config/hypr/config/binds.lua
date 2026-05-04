--------------------
---- KEYBINDING ----
--------------------

local mainMod = "SUPER"

local fileManager = "dolphin"
local menu = "pkill wofi || wofi --show drun --allow-images --hide-scroll"
local terminal = "kitty"

--- Controles
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SPACE", hl.exec_cmd(menu))
hl.bind(mainMod == " + E", hl.dsp.layout("togglesplit"))

--- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

--- Move window to workspace and scroll
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. "period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. "comma", hl.dsp.layout("move -col"))

--- Move Workspace
hl.bind(mainMod .. " + CTRL + right", hl.dsp.workspace.move({ "right" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.workspace.move({ "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.workspace.move({ "right" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.workspace.move({ "left" }))

--- Window Modes
hl.bind(mainMod .. " + F", hl.dsp.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.float({ action = "toggle" }))

--- Group Modes
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())
hl.bind(mainMod .. " + P", hl.dsp.group.next())
hl.bind(mainMod .. " + O", hl.dsp.group.prev())

--- Move and resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--- Multimedia keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--- Screenshot and Colourpicker
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output --freeze -o /home/david/hdd/screenshots/"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region --freeze -o /home/david/hdd/screenshots/"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window --freeze -o /home/david/hdd/screenshots/"))

hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd("sh -c $HOME/.config/hypr/scripts/colour_picker.sh"))

--- Open Menus
local openMenu = mainMod .. " + SHIFT"
hl.bind(openMenu .. " + Q", hl.dsp.exec_cmd("sh -c $HOME/.config/rofi/power.sh"))
hl.bind(openMenu .. " + A", hl.dsp.exec_cmd("sh -c $HOME/.config/rofi/audio-control.sh"))

--- Open Apps
local openApp = mainMod .. " + ALT"
hl.bind(openApp .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(openApp .. " + P", hl.dsp.exec_cmd("ferdium"))
hl.bind(openApp .. " + M", hl.dsp.exec_cmd("spotify-launcher"))
hl.bind(openApp .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd('kitty -- sh -c "bash -c "btop; exec bash""'))

--- Widgets
local toggleWidget = "CTRL + " .. mainMod .. " + ALT"
hl.bind(toggleWidget .. " + C", hl.dsp.exec_cmd('bash ~/.config/hypr/scripts/qs_manager.sh "Calendar"'))
