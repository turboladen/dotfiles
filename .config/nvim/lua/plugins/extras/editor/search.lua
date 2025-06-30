return {
  -- Simple search enhancements without jump labels
  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Keep it minimal and less cluttered
      calm_down = true, -- Clear lens when cursor moves away
      nearest_only = true, -- Only show lens for nearest match
      nearest_float_when = "never", -- Never use floating window, only virtual text
      override_lens = function(render, posList, nearest, idx, relIdx)
        local cnt = #posList
        local text = string.format("[%d/%d]", idx, cnt)
        local chunks = { { " " }, { text, "HlSearchLensNear" } }
        render.setVirt(0, posList[idx][1] - 1, posList[idx][2] - 1, chunks, nearest)
      end,
    },
    keys = {
      {
        "n",
        [[<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>]],
        desc = "Next search match"
      },
      {
        "N",
        [[<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>]],
        desc = "Previous search match"
      },
      {
        "*",
        [[*<cmd>lua require('hlslens').start()<CR>]],
        desc = "Search word under cursor forward"
      },
      {
        "#",
        [[#<cmd>lua require('hlslens').start()<CR>]],
        desc = "Search word under cursor backward"
      },
      {
        "g*",
        [[g*<cmd>lua require('hlslens').start()<CR>]],
        desc = "Search partial word under cursor forward"
      },
      {
        "g#",
        [[g#<cmd>lua require('hlslens').start()<CR>]],
        desc = "Search partial word under cursor backward"
      },
      {
        "<leader>l",
        "<cmd>noh<CR>",
        desc = "Clear search highlight"
      },
    },
  },
}
