-- I really don't get it, but I can't get this dumb theme to pick up these settings
-- at all. If I set nightfox first, I still can't tell if these settings are getting
-- detected, but it at least ends up with a theme that I like.
--
vim.cmd([[colorscheme nightfox]])

vim.g.everforest_background = "hard"

-- Without this, the background is too light.
vim.g.everforest_transparent_background = 1
-- vim.g.everforest_ui_contrast = "low"

vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_diagnostic_virtual_text = "colored"

vim.g.everforest_enable_italic = 1

-- NOTE: For some dumb reason, I have to call this here; just calling in init.vim doesn't work right.
-- vim.cmd([[colorscheme everforest]])
