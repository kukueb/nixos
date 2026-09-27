hl.on("hyprland.start", function()
	hl.exec_cmd("gsr-ui launch-daemon")
	hl.exec_cmd("throne", { workspace = "10 silent", monitor = "HDMI-A-1" })
end)
