hl.bind(
	"CTRL+SUPER+ALT+Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"),
	{ description = "Edit user keybinds" }
)

for i = 1, 10 do
	hl.bind("SUPER + SHIFT + " .. (i % 10), hl.dsp.window.move({ workspace = tostring(i) }))
	hl.bind("SUPER + CTRL + " .. (i % 10), hl.dsp.window.move({ workspace = tostring(i), follow = false }))
end

--# Windows
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- Moving if floating
local function move_or_resize(dx, dy)
	local win = hl.get_active_window()
	if win and win.floating then
		hl.dispatch(hl.dsp.window.move({ x = dx, y = dy, relative = true }))
	else
		hl.dispatch(hl.dsp.window.resize({ x = dx, y = dy, relative = true }))
	end
end

local binds = {
	{ key = "L", dx = 50, dy = 0 },
	{ key = "H", dx = -50, dy = 0 },
	{ key = "K", dx = 0, dy = -50 },
	{ key = "J", dx = 0, dy = 50 },
}

for _, b in ipairs(binds) do
	hl.bind("SUPER + CTRL + " .. b.key, function()
		move_or_resize(b.dx, b.dy)
	end, { repeating = true })
end
--

hl.bind("SUPER + ALT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + ALT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + ALT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + ALT + J", hl.dsp.window.swap({ direction = "d" }))

-- Alt+Tab: cycle forward through all windows (floating + tiled)
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Alt+Shift+Tab: cycle backward
hl.bind("ALT + SHIFT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

--# Workspaces
hl.bind("SUPER + Right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER + Left", hl.dsp.focus({ workspace = "m-1" }))

hl.bind("SHIFT + SUPER + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SHIFT + SUPER + H", hl.dsp.focus({ workspace = "-1" }))

hl.bind("SHIFT + SUPER + J", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SHIFT + SUPER + K", hl.dsp.focus({ workspace = "-1" }))

hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("rofi -show drun"), { description = "Old, rofi app launcher" })

-- Scrolling
hl.bind("SUPER + bracketright", hl.dsp.layout("consume"))
hl.bind("SUPER + bracketleft", hl.dsp.layout("expel"))
