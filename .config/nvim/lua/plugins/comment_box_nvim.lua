--  ╭──────────────────────────────────────────────────────────╮
--  │    ✨ Clarify and beautify your comments using boxes     │
--  │                        and lines.                        │
--  ╰──────────────────────────────────────────────────────────╯
local Plugin = { "LudoPinelli/comment-box.nvim" }

Plugin.lazy = true
Plugin.cmd = {
  --  ╭──────────────────────────────────────────────────────────╮
  --  │ Left aligned boxes                                       │
  --  ╰──────────────────────────────────────────────────────────╯
  "CBllbox", -- Left-aligned box of fixed size with Left-aligned text
  "CBlcbox", -- Left-aligned box of fixed size with centered text
  "CBlrbox", -- Left-aligned box of fixed size with Right-aligned text

  --         ╭──────────────────────────────────────────────────────────╮
  --         │ Centered boxes                                           │
  --         ╰──────────────────────────────────────────────────────────╯
  "CBclbox", -- Centered box of fixed size with Left-aligned text
  "CBccbox", -- Centered box of fixed size with centered text
  "CBcrbox", -- Centered box of fixed size with Right-aligned text

  --                  ╭──────────────────────────────────────────────────────────╮
  --                  │ Right aligned boxes                                      │
  --                  ╰──────────────────────────────────────────────────────────╯
  "CBrlbox", -- Right-aligned box of fixed size with Left-aligned text
  "CBrcbox", -- Right-aligned box of fixed size with centered text
  "CBrrbox", -- Right-aligned box of fixed size with Right-aligned text

  --  ╭───────────────╮
  --  │ Adapted boxes │
  --  ╰───────────────╯
  "CBalbox", -- Left-aligned adapted box
  "CBacbox", -- Centered adapted box
  "CBarbox", -- Right-aligned adapted box

  --  ────────────────────────────────────────────────────────────
  --    Line things
  --  ├──────────────────────────────────────────────────────────┤
  "CBline",  -- Left-aligned line
  "CBcline", -- Centered line
  "CBrline", -- Right-aligned line

  -- Show the catalog
  "CBcatalog"
}

---Make an adapted box with left-aligned text, then format.
--
---@param style number
Plugin.al_box = function(style)
  require("comment-box").albox(style)
  vim.lsp.buf.format({ async = false })
end


---Make an centered box with centered text, then format. Good for file headers.
--
---@param style number
Plugin.cc_box = function(style)
  style = style or 3
  require("comment-box").ccbox(style)
  vim.lsp.buf.format({ async = false })
end

return Plugin
