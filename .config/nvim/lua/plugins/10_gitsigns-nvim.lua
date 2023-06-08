-- ╭────────────────────────────────────────────────╮
-- │ Use dependency and run lua function after load │
-- ╰────────────────────────────────────────────────╯
local function get_next_hunk()
  if vim.wo.diff then return ']c' end
  vim.schedule(function() require("gitsigns").next_hunk() end)
  return '<Ignore>'
end

local function get_prev_hunk()
  if vim.wo.diff then return '[c' end
  vim.schedule(function() require("gitsigns").prev_hunk() end)
  return '<Ignore>'
end

local function toggle_blame()
  require("gitsigns").toggle_current_line_blame()
end

return {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = {
      add = { text = "✚" },
      change = { text = "✹" },
      delete = { text = "✖" },
      changedelete = { text = "⇄" },
    },
    current_line_blame = true,
    yadm = { enable = true },
    -- on_attach = function(bufnr)
    --   local gs = package.loaded.gitsigns

    -- local function map(mode, l, r, opts)
    --   opts = opts or {}
    --   opts.buffer = bufnr
    --   vim.keymap.set(mode, l, r, opts)
    -- end

    -- Actions
    -- map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    -- map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    -- map("n", "<leader>hS", gs.stage_buffer)
    -- map("n", "<leader>hu", gs.undo_stage_hunk)
    -- map("n", "<leader>hR", gs.reset_buffer)
    -- map("n", "<leader>hp", gs.preview_hunk)
    -- map("n", "<leader>hb", function()
    --     gs.blame_line({ full = true })
    -- end)
    -- map("n", "<leader>hd", gs.diffthis)
    -- map("n", "<leader>hD", function()
    --     gs.diffthis("~")
    -- end)
    -- map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    -- end,
  },
  keys = {
    { "]c",         get_next_hunk, { expr = true, desc = "Get next git hunk" } },
    { "[c",         get_prev_hunk, { expr = true, desc = "Get previous git hunk" } },
    { "<leader>tb", toggle_blame,  { expr = true, desc = "Toggle git blame for current line" } },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end
}
