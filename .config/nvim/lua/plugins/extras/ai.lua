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
          accept = "<S-Tab>",
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
      -- copilot_model = "gpt-5",
      copilot_model = "claude-sonnet-4",
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
        http = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-sonnet-4",
                },
              },
            })
          end,
          fuel_ix = function()
            return require("codecompanion.adapters").extend("openai", {
              name = "fuel_ix",
              formatted_name = "Fuel IX",
              url = "https://api.fuelix.ai/v1/chat/completions",
              env = {
                api_key = "cmd:op read 'op://Employee/Fuel iX Copilot Dev API Key/credential' --no-newline",
              },
              schema = {
                model = {
                  default = "claude-sonnet-4",
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          -- adapter = "copilot",
          adapter = "fuel_ix",
        },
        inline = {
          adapter = "copilot",
        },
      },
    },
  },
}
