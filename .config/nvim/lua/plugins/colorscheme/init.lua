return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        dim_inactive = true,
        colorblind = {
          enable = true,
        },
        styles = {
          comments = "italic",
          keywords = "italic",
          types = "italic,bold",
        },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
    end,
  },
  {
    "neanias/everforest-nvim",
    lazy = true,
    opts = {
      italics = true,
      ui_contrast = "high",
      dim_inactive_windows = true,
      diagnostic_line_highlight = true,
      spell_foreground = true,
    },
    config = function(_, opts)
      require("everforest").setup(opts)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      compile = true,
      dimInactive = true,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
      lualine_bold = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },
}
