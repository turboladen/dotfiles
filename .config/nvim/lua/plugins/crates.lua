--  ╭────────────────────────────────────────────────────────────╮
--  │ A neovim plugin that helps managing crates.io dependencies │
--  ╰────────────────────────────────────────────────────────────╯
-- local Plugin = { "saecki/crates.nvim" }
--
-- Plugin.tag = "stable"
-- Plugin.event = { "BufRead Cargo.toml", "BufRead *.rs" }
-- Plugin.lazy = true
--
-- Plugin.config = function()
--   require("crates").setup({
--     lsp = {
--       enabled = true,
--       on_attach = function(_, bufnr)
--         require("user.keymaps").crates(bufnr)
--       end,
--       actions = true,
--       completion = true,
--       hover = true
--     }
--   })
-- end
--
-- return Plugin
require("crates").setup({
  lsp = {
    enabled = true,
    -- on_attach = function(_, bufnr)
    --   require("user.keymaps").crates(bufnr)
    -- end,
    actions = true,
    completion = true,
    hover = true
  }
})
