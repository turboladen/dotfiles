require("codecompanion").setup({
  -- opts = {
  --   log_level = "DEBUG"
  -- },
  strategies = {
    chat = {
      -- adapter = "openai_compatible"
      -- adapter = "fuelix"
      adapter = "copilot"
    },
    inline = {
      -- adapter = "openai"
      -- adapter = "openai_compatible"
      adapter = "copilot"
    }
  },
  -- adapters = {
  --   fuelix = function()
  --     return require("codecompanion.adapters").extend("openai", {
  --       env = {
  --         api_key = "cmd:op read op://Private/Fuel iX API Key/credential --no-newline",
  --         url = "https://proxy.feulix.ai",
  --       },
  --       schema = {
  --         model = {
  --           default = "claude-3-5-sonnet"
  --         }
  --       }
  --     })
  --   end
  -- }
})
