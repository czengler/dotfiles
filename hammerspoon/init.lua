-- you need to use the following command to move the default hammerspoon config to .config
-- defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

-------------------------------------------------------
-- Automatically reload the hammerspon configuration --
-------------------------------------------------------
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

------------
-- Styles --
------------

-- shorter window animations
hs.window.animationDuration = 0.0

-- Foreground color for choosers 255 0 246
local mainColor = hs.drawing.color.asRGB({ hex = "#9ece6a" })

-- Alert style
hs.alert.defaultStyle.strokeWidth = 1
hs.alert.defaultStyle.strokeColor = mainColor
hs.alert.defaultStyle.radius = 0
hs.alert.defaultStyle.fadeInDuration = 0.10
hs.alert.defaultStyle.fadeOutDuration = 0.8
hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.7 }

-- stylized alert
local function alert(text)
	hs.alert.show(hs.styledtext.new(text, { font = { name = "Berkeley Mono", size = 18 }, color = mainColor }))
end

-------------
-- Helpers --
-------------

-- Bind keybindings to CMD+ALT+CTRL on laptop and keyboard
local function bind_laptop_and_keyboard(key, func)
	local laptop_modifiers = { "cmd", "alt", "ctrl" }
	hs.hotkey.bind(laptop_modifiers, key, func)
end

-------------------------
-- Window manipulation --
-------------------------
hs.loadSpoon("WinWin")

local function center_window()
	local cwin = hs.window.focusedWindow()
	if cwin then
		local cscreen = cwin:screen()
		local cres = cscreen:frame()
		cwin:setFrame({
			x = cres.x + (cres.w / 8),
			y = cres.y + (cres.h / 8),
			w = cres.w - (cres.w / 4),
			h = cres.h - (cres.h / 4),
		})
	end
end

-- Basic window placement in halfs (H, J, K, L) and corners (Y, U, B, N)
bind_laptop_and_keyboard("H", function()
	spoon.WinWin:moveAndResize("halfleft")
end)

bind_laptop_and_keyboard("L", function()
	spoon.WinWin:moveAndResize("halfright")
end)

bind_laptop_and_keyboard("K", function()
	spoon.WinWin:moveAndResize("halfup")
end)

bind_laptop_and_keyboard("J", function()
	spoon.WinWin:moveAndResize("halfdown")
end)

bind_laptop_and_keyboard("Y", function()
	spoon.WinWin:moveAndResize("cornerNW")
end)

bind_laptop_and_keyboard("U", function()
	spoon.WinWin:moveAndResize("cornerNE")
end)

bind_laptop_and_keyboard("B", function()
	spoon.WinWin:moveAndResize("cornerSW")
end)

bind_laptop_and_keyboard("N", function()
	spoon.WinWin:moveAndResize("cornerSE")
end)

-- Maximize windows
bind_laptop_and_keyboard("M", function()
	spoon.WinWin:moveAndResize("maximize")
end)

-- Center windows
bind_laptop_and_keyboard("C", center_window)

-- Move windows to screens
bind_laptop_and_keyboard("9", function()
	spoon.WinWin:moveToScreen("left")
end)

bind_laptop_and_keyboard("0", function()
	spoon.WinWin:moveToScreen("right")
end)

-- toggle sleep allowed
local function switch_sleepable()
	hs.caffeinate.toggle("displayIdle")
	hs.caffeinate.toggle("systemIdle")
	local sleep_prevented = hs.caffeinate.toggle("system")
	if sleep_prevented then
		alert("Sleep prevented")
	else
		alert("Sleep allowed")
	end
end

bind_laptop_and_keyboard("Z", switch_sleepable)
