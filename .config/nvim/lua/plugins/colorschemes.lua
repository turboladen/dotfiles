return {
  -- ╭────────────────────────────────────────────────────────────────────────╮
  -- │ 🦊A highly customizable theme for vim and neovim with support for lsp, │
  -- │ treesitter and a variety of plugins.                                   │
  -- ╰────────────────────────────────────────────────────────────────────────╯
  {
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        dim_inactive = true,
        colorblind = {
          enable = true
        },
        styles = {
          comments = "italic",
          keywords = "italic",
          types = "italic,bold",
        }
      },
    },
  },

  -- ╭────────────────────────────────────────────────╮
  -- │ 🌲 Comfortable & Pleasant Color Scheme for Vim │
  -- ╰────────────────────────────────────────────────╯
  {
    "sainnhe/everforest",
    event = "VeryLazy",
    init = function()
      vim.g.everforest_background = "hard"

      -- Without this, the background is too light.
      vim.g.everforest_transparent_background = 1
      -- vim.g.everforest_ui_contrast = "low"

      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_diagnostic_virtual_text = "colored"

      vim.g.everforest_enable_italic = 1
    end
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ NeoVim dark colorscheme inspired by the colors of the famous             │
  -- │ painting by Katsushika Hokusai.                                          │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
  },

  -- ╭──────────────────────────────────────────────────────╮
  -- │ A very dark colorscheme for Vim. JOIN THE DARK SIDE! │
  -- ╰──────────────────────────────────────────────────────╯
  {
    "aonemd/kuroi.vim",
    event = "VeryLazy",
  },

  -- ╭─────────────────────────────────────────────────────────────────────────╮
  -- │ 🔱 Material colorscheme for NeoVim written in Lua with built-in support │
  -- │ for native LSP, TreeSitter and many more plugins .                      │
  -- ╰─────────────────────────────────────────────────────────────────────────╯
  {
    "marko-cerovac/material.nvim",
    event = "VeryLazy",
    dependencies = {
      require("plugins.telescope_nvim")
    },
    opts = {
      contrast = {
        floating_windows = true,
        cursor_line = true,
        non_current_windows = true,
        sidebars = true,
      },
      plugins = {
        "dap",
        "gitsigns",
        "mini",
        "neotest",
        "noice",
        "nvim-cmp",
        "nvim-web-devicons",
        "telescope",
        "trouble",
        "which-key",
      }
    },
    init = function()
      vim.g.material_style = "deep ocean"
    end,
    config = function(_, opts)
      require("material").setup(opts)
      -- vim.keymap.set("n", "<leader>C", require("material.functions").find_style(),
      --   { desc = "Pick 'material-nvim' colorscheme style" })
    end,
    keys = {
      {
        "<leader>mm",
        function()
          require("material.functions").find_style()
        end,
        desc = "Pick material-nvim colorscheme style"
      }
    }
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ One dark and light colorscheme for neovim >= 0.5.0 written in lua based  │
  -- │ on Atom's One Dark and Light theme. Additionally, it comes with 5 color  │
  -- │ variant styles.                                                          │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  -- {
  --   "navarasu/onedark.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     style = "darker"
  --   }
  -- }
  {
    "olimorris/onedarkpro.nvim"
  },

  {
    "ray-x/aurora",
    init = function()
      vim.g.aurora_italic = 1
    end
  }
}
