-- ╭─────────────────────────────────────────────────────────╮
-- │ Prismatic line decorations for the adventurous vim user │
-- ╰─────────────────────────────────────────────────────────╯
return {
	"mvllow/modes.nvim",
	tag = "v0.2.0",
	init = function()
		vim.opt.cursorline = true
	end,
	config = function()
		require("modes").setup()
	end
}
