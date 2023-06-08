-- ╭──────────────────────────╮
-- │ Hlsearch Lens for Neovim │
-- ╰──────────────────────────╯
return {
  "kevinhwang91/nvim-hlslens",
  keys = {
    {
      "n",
      [[<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>]],
      { desc = "Go to next search match" }
    },
    {
      "N",
      [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>]],
      { desc = "Go to previous search match" }
    },
    {
      "*",
      [[*<cmd>lua require('hlslens').start()<CR>]],
      { desc = "Search forward for <word> under cursor" }
    },
    {
      "#",
      [[#<cmd>lua require('hlslens').start()<CR>]],
      { desc = "Search backward for <word> under cursor" }
    },
    {
      "g*",
      [[g*<cmd>lua require('hlslens').start()<CR>]],
      { desc = "Search forward for word under cursor" }
    },
    {
      "g#",
      [[g#<cmd>lua require('hlslens').start()<CR>]],
      { desc = "Search backward for word under cursor" }
    },
    { "<leader>l", ":noh<CR>", { desc = "Stop highlighting the hlsearch" } },
  },
  config = function()
    require("hlslens").setup({})
  end
}
