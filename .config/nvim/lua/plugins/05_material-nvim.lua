-- ╭─────────────────────────────────────────────────────────────────────────╮
-- │ 🔱 Material colorscheme for NeoVim written in Lua with built-in support │
-- │ for native LSP, TreeSitter and many more plugins .                      │
-- │                                                                         │
-- │ NOTE: To enable this, edit the setup file.                              │
-- ╰─────────────────────────────────────────────────────────────────────────╯
return {
	"marko-cerovac/material.nvim",
	lazy = true,
	opts = {
		contrast = {
			floating_windows = true,
			cursor_line = true,
			non_current_windows = true,
		},
		plugins = {
			"dap",
			"gitsigns",
			"indent-blankline",
			"nvim-cmp",
			"nvim-web-devicons",
			"telescope",
			"trouble"
		}
	},
	init = function()
		vim.g.material_style = "darker"
		-- vim.g.material_style = "deep ocean"
		-- vim.g.material_style = "oceanic"
		-- vim.g.material_style = "palenight"
		-- vim.g.material_style = "lighter"
	end
}
