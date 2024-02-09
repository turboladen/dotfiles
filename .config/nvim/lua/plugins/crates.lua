--  ╭────────────────────────────────────────────────────────────╮
--  │ A neovim plugin that helps managing crates.io dependencies │
--  ╰────────────────────────────────────────────────────────────╯
local Plugin = { "saecki/crates.nvim" }

Plugin.tag = "v0.4.0"
Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.event = { "BufRead Cargo.toml" }
Plugin.lazy = true
Plugin.init = function()
  require("user.commands").crates()
end

Plugin.config = function()
  require("crates").setup()
end

return Plugin
