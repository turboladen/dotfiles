-- ╭─────────────────────────────────╮
-- │ Quickstart configs for Nvim LSP │
-- ╰─────────────────────────────────╯
local Plugin = { "onsails/lspkind-nvim" }

-- event = "LspAttach",
Plugin.event = "BufEnter"
Plugin.opts = {
  mode = "symbol"
}
Plugin.config = function(_, opts)
  require("lspkind").init(opts)
end

return Plugin
