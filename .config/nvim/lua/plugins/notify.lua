--  ╭────────────────────────────────────────────────────────╮
--  │ A fancy, configurable, notification manager for NeoVim │
--  ╰────────────────────────────────────────────────────────╯
local Plugin = { "rcarriga/nvim-notify" }

Plugin.event = "VeryLazy"
-- Plugin.enabled = false

Plugin.dependencies = {
  "nvim-telescope/telescope.nvim",
}

Plugin.init = function()
  vim.opt.termguicolors = true
end

Plugin.opts = {
  render = "wrapped-compact"
}

Plugin.config = function(opts)
  local notify = require("notify")
  vim.notify = notify
  notify.setup(opts)

  local telescope = require("telescope")
  telescope.load_extension("notify")

  vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
      'ERROR',
      'WARN',
      'INFO',
      'DEBUG',
    })[result.type]
    notify({ result.message }, lvl, {
      title = 'LSP | ' .. client.name,
      timeout = 10000,
      keep = function()
        return lvl == 'ERROR' or lvl == 'WARN'
      end,
    })
  end
end

return Plugin
