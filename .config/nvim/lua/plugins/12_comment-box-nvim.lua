-- ╭──────────────────────────────────────────────────────────────╮
-- │ ✨ Clarify and beautify your comments using boxes and lines. │
-- ╰──────────────────────────────────────────────────────────────╯
return {
  "LudoPinelli/comment-box.nvim",
  cmd = {
    "CBlbox",     -- Left aligned box of fixed size with Left aligned text
    "CBclbox",    -- Centered box of fixed size with Left aligned text
    "CBcbox",     -- Left aligned box of fixed size with centered text
    "CBccbox",    -- Centered box of fixed size with centered text
    "CBalbox",    -- Left aligned adapted box with Left aligned text
    "CBaclbox",   -- Centered adapted box with Left aligned text
    "CBacbox",    -- Left aligned adapted box with centered text
    "CBaccbox",   -- Centered adapted box with centered text
  }
}
