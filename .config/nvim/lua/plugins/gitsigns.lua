--  ╭─────────────────────────────╮
--  │ Git integration for buffers │
--  ╰─────────────────────────────╯
local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
  signs = {
    changedelete = { text = "⇄" },
  },
  yadm = { enable = true },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function get_next_hunk()
      if vim.wo.diff then return ']c' end
      -- vim.schedule(function() require("gitsigns").next_hunk() end)
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end

    local function get_prev_hunk()
      if vim.wo.diff then return '[c' end
      -- vim.schedule(function() require("gitsigns").prev_hunk() end)
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end

    local function toggle_blame()
      -- require("gitsigns").toggle_current_line_blame()
      gs.toggle_current_line_blame({ full = true })
    end

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    -- Actions
    map("n", "]c", get_next_hunk, "Next hunk")
    map("n", "[c", get_prev_hunk, "Previous hunk")
    map("n", "<leader>ghb", toggle_blame, "Toggle git blame line")
  end,
}

return Plugin
