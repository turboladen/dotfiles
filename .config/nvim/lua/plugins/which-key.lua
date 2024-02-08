--  ╭────────────────────────────────────╮
--  │ 💥 Create key bindings that stick. │
--  ╰────────────────────────────────────╯
local Plugin = { "folke/which-key.nvim" }

Plugin.event = "VeryLazy"

-- Plugin.init = function()
--   vim.o.timeout = true
--   vim.o.timeoutlen = 300
-- end

Plugin.opts = {
  plugins = {
    -- spelling = true,
    presets = {
      windows = false,
      nav = false
    }
  },
  defaults = {
    ["g"] = { name = "+goto" },
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["<leader><tab>"] = { name = "+tabs" },
    ["<leader>b"] = { name = "+buffer" },
    ["<leader>c"] = { name = "+code" },
    ["<leader>f"] = { name = "+file/find" },
    ["<leader>g"] = { name = "+git" },
    ["<leader>t"] = { name = "+test" },
    ["<leader>s"] = { name = "+search" },
    ["<leader>u"] = { name = "+ui" },
    ["<leader>w"] = { name = "+windows" },
    ["<leader>x"] = { name = "+diagnostics/quickfix" },
  }
}
Plugin.config = function(_, opts)
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(opts.defaults)
end


return Plugin
