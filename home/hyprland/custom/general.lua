hl.config({
	input = {
		-- List your layouts separated by commas (e.g., US English and Russian)
		kb_layout = "us,ru",

		-- Specify variants for each layout respectively (leave blank if default)
		kb_variant = "",

		-- Define the shortcut combination to toggle between layouts
		kb_options = "grp:alt_shift_toggle",

		-- Recommended: ensures keybinds work reliably regardless of active layout
		resolve_binds_by_sym = 1,

		-- follow_mouse = 1,
	},

	general = {
		layout = "scrolling",
	},
})
