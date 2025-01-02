-- ╭─────────────────────────────────────────────────────────╮
-- │ lsp_lines is a simple neovim plugin that renders        │
-- │ diagnostics using virtual lines on top of the real      │
-- │ line of code.                                           │
-- ╰─────────────────────────────────────────────────────────╯
local Plugin = { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }

Plugin.enabled = false

Plugin.config = function()
  require("lsp_lines").setup()
  vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
end

return Plugin
