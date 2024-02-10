return {

  --  ╭──────────────────────────────────────────────────────────────────────────────╮
  --  │ A tree like view for symbols in Neovim using the Language Server             │
  --  │  Protocol. Supports all your favourite languages.                            │
  --  ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    "simrat39/symbols-outline.nvim",
    enabled = false,
    event = "VeryLazy",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    opts = {},
  },

  -- ╭──────────────────────────────────────────────────╮
  -- │ ✍️ All the npm/yarn commands I don't want to type │
  -- ╰──────────────────────────────────────────────────╯
  {
    "vuki656/package-info.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      local package_info = require('package-info')
      package_info.setup()

      -- vim.keymap.set({ "n" }, "<LEADER>ns", package_info.show, { desc = "Show dependency versions" })
      -- vim.keymap.set({ "n" }, "<LEADER>nc", package_info.hide, { desc = "Hide dependency versions" })
      -- vim.keymap.set({ "n" }, "<LEADER>nu", package_info.update, { desc = "Update dependency on the line" })
      -- vim.keymap.set({ "n" }, "<LEADER>nd", package_info.delete, { desc = "Delete dependency on the line" })
      -- vim.keymap.set({ "n" }, "<LEADER>ni", package_info.install, { desc = "Install a new dependency" })
      -- vim.keymap.set({ "n" }, "<LEADER>np", package_info.change_version,
      --   { desc = "Install a different dependency version" })
    end
  },
}
