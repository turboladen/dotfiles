-- ╭────────────────────────────────────────────────╮
-- │ 🌲 Comfortable & Pleasant Color Scheme for Vim │
-- │                                                │
-- │ NOTE: To enable this, edit the setup file.     │
-- ╰────────────────────────────────────────────────╯
return {
	"sainnhe/everforest",
	lazy = true,
	init = function()
		vim.g.everforest_background = "hard"

		-- Without this, the background is too light.
		vim.g.everforest_transparent_background = 1
		-- vim.g.everforest_ui_contrast = "low"

		vim.g.everforest_diagnostic_text_highlight = 1
		vim.g.everforest_diagnostic_line_highlight = 1
		vim.g.everforest_diagnostic_virtual_text = "colored"

		vim.g.everforest_enable_italic = 1
	end
}
