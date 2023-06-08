-- ╭───────────────────────────╮
-- │ Hyperfocus-writing in Vim │
-- ╰───────────────────────────╯
return {
	"junegunn/limelight.vim",
	cmd = "Limelight",
	init = function()
		vim.g.limelight_paragraph_span = 1
	end
}
