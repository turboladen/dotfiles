return {
  -- Edit directories like buffers
  {
    "elihunter173/dirbuf.nvim",
    opts = {},
  },

  -- Fast fuzzy finder
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader><cr>", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
      {
        "<leader>fn",
        function()
          require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find neovim config files",
      },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>ss", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP workspace symbols" },
    },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          scrollbar = "float",
        },
      },
      keymap = {
        builtin = {
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["ctrl-j"] = "down",
          ["ctrl-k"] = "up",
          ["alt-a"] = "toggle-all",
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      previewers = {
        bat = {
          cmd = "bat",
          args = "--style=numbers,changes --color always",
          theme = "Coldark-Dark",
        },
      },
      files = {
        prompt = "Files❯ ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true,
        color_icons = true,
        sort_lastused = true,
      },
      lsp = {
        prompt_postfix = "❯ ",
        cwd_only = true,
      },
    },
  },
}
