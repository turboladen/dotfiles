--  ╭──────────────────────────────────────────────────────────╮
--  │    ✨ Clarify and beautify your comments using boxes     │
--  │                        and lines.                        │
--  ╰──────────────────────────────────────────────────────────╯
-- { "LudoPinelli/comment-box.nvim" }

local M = {}

---Make an adapted box with left-aligned text, then format.
--
---@param style number
M.al_box = function(style)
  require("comment-box").albox(style)
  vim.lsp.buf.format({ async = false })
end


---Make an centered box with centered text, then format. Good for file headers.
--
---@param style number
M.cc_box = function(style)
  style = style or 3
  require("comment-box").ccbox(style)
  vim.lsp.buf.format({ async = false })
end

return M
