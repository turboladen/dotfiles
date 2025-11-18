-- Extra colorschemes for testing and experimentation
-- These are not part of the core colorscheme setup
return {
  {
    "dericktseng/balance-theme.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("balance-theme").setup(opts)
    end,
  },
  {
    "ribru17/bamboo.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
      ending_tildes = true,
      lualine = {
        transparent = true,
      },
      diagnostics = {
        darker = true,
      },
    },
    config = function(_, opts)
      require("bamboo").setup(opts)
    end,
  },
  {
    "projekt0n/caret.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("caret").setup(opts)
    end,
  },
  {
    "verf/deepwhite.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("deepwhite").setup(opts)
    end,
  },
  {
    "sebasruiz09/fizz.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("fizz").setup(opts)
    end,
  },
  {
    "mkarmona/materialbox",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("materialbox").setup(opts)
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("modus-themes").setup(opts)
    end,
  },
  {
    "yorik1984/newpaper.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("newpaper").setup(opts)
    end,
  },
  {
    "talha-akram/noctis.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("noctis").setup(opts)
    end,
  },
  {
    "e-q/okcolors.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("okcolors").setup(opts)
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    init = function()
      vim.g.sonokai_style = "shusia"
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_dim_inactive_windows = 1
    end,
  },
  {
    "yorickpeterse/vim-paper",
    lazy = true,
    init = function()
      vim.g.paper_dim_inactive = 1
    end,
  },
  {
    "owickstrom/vim-colors-paramount",
    lazy = true,
    init = function()
      -- Note: This is a vim colorscheme, may need manual dim_inactive setup
    end,
  },
}
