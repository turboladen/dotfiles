require("gitsigns").setup({
  signs = {
    changedelete = { text = "⇄" },
  },
  on_attach = function(bufnr)
    require("user.keymaps").gitsigns(bufnr)
  end,
})

local M = {}

M.get_next_hunk = function()
  -- if vim.wo.diff then return ']c' end
  -- vim.schedule(function() gs.next_hunk() end)

  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    require("gitsigns").nav_hunk('next')
  end
end

M.get_prev_hunk = function()
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

M.toggle_blame = function()
  require("gitsigns").toggle_current_line_blame({ full = true })
end

return M
