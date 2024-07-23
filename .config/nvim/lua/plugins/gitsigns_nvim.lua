--  ╭─────────────────────────────╮
--  │ Git integration for buffers │
--  ╰─────────────────────────────╯
local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  {
    "seanbreckenridge/gitsigns-yadm.nvim",
    opts = {
      shell_timeout_ms = 1000
    }
  }
}

Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
  signs = {
    changedelete = { text = "⇄" },
  },
  _on_attach_pre = function(_, callback)
    if vim.fn.executable("yadm") == 1 then
      require("gitsigns-yadm").yadm_signs(callback)
    else
      callback()
    end
  end,
  on_attach = function(bufnr)
    require("user.keymaps").gitsigns(bufnr)
  end,
}

Plugin.get_next_hunk = function()
  -- if vim.wo.diff then return ']c' end
  -- vim.schedule(function() gs.next_hunk() end)

  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    require("gitsigns").nav_hunk('next')
  end
end

Plugin.get_prev_hunk = function()
  -- if vim.wo.diff then return '[c' end
  -- vim.schedule(function() require("gitsigns").prev_hunk() end)
  -- vim.schedule(function() gs.prev_hunk() end)
  -- return '<Ignore>'
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    require("gitsigns").nav_hunk('prev')
  end
end

Plugin.toggle_blame = function()
  require("gitsigns").toggle_current_line_blame({ full = true })
end

return Plugin
