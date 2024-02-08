local Plugin  = { "zbirenbaum/copilot.lua" }

Plugin.cmd    = "Copilot"
-- event = "VeryLazy"
Plugin.event  = "InsertEnter"

Plugin.opts   = {
  suggestion = {
    auto_trigger = true,
    debounce = 300,
  },
  filetypes = {
    markdown = true,
    gitcommit = true,
    gitrebase = true,
  }
}

Plugin.config = function(opts)
  require("copilot").setup(opts)
end

-- { "github/copilot.vim" },

return Plugin
