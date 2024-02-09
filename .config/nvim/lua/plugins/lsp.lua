return {
  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │  Portable package manager for Neovim that runs everywhere Neovim         │
  -- │  runs.                                                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
          { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
        },
        opts = {},
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = false,
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-lspconfig").setup(opts)
    end
  },

  -- ╭─────────────────────────────────╮
  -- │ Quickstart configs for Nvim LSP │
  -- ╰─────────────────────────────────╯
  {
    "onsails/lspkind-nvim",
    -- event = "LspAttach",
    event = "BufEnter",
    opts = {
      mode = "symbol"
    },
    config = function(_, opts)
      require("lspkind").init(opts)
    end
  },
}
