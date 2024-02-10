-- { "github/copilot.vim" },
local Plugin  = { "zbirenbaum/copilot.lua" }

Plugin.cmd    = "Copilot"
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

return Plugin
