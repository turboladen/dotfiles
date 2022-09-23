require("aerial").setup(
  {
    default_direction = "prefer_left",
    placement_editor_edge = true,
    filter_kind = false
  }
)

local aerial = {}

function aerial.setup(client, bufnr)
  require("aerial").on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Aerial does not set any mappings by default, so you'll want to set some up
  -- Toggle the aerial window with <leader>a
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>aa", "<cmd>AerialToggle!<CR>", opts)

  -- Jump forwards/backwards with '{' and '}'
   vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", opts)
   vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", opts)

  -- Jump up the tree with '[[' or ']]'
   vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", opts)
   vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", opts)

   vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>at", "<cmd>ArealTreeToggle<CR>", opts)
   vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ao", "<cmd>ArealTreeOpenAll<CR>", opts)
end

return aerial
