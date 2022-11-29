require("aerial").setup(
  {
    filter_kind = false,
    on_attach = function(bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Aerial does not set any mappings by default, so you'll want to set some up
      -- Toggle the aerial window with <leader>a
      vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>", opts)

      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", opts)
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", opts)

      -- Jump up the tree with '[[' or ']]'
      vim.keymap.set("n", "[[", "<cmd>lua require('aerial').prev_up()<CR>", opts)
      vim.keymap.set("n", "]]", "<cmd>lua require('aerial').next_up()<CR>", opts)
    end
  }
)
