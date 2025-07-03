return {
  -- GitHub Copilot integration
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
    },
  },

  -- AI coding companion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
    },
    keys = {
      { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
      {
        "<leader>ac",
        function()
          require("codecompanion").chat()
        end,
        mode = { "n", "v" },
        desc = "AI Chat",
      },
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {})
        end,
      },
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },
    },
  },
}
