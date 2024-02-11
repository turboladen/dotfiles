local Plugin = { "williamboman/mason.nvim" }

Plugin.opts = {}

Plugin.config = function(_, opts)
  require("mason").setup()
end

return Plugin
