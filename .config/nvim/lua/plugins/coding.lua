return {
  -- Modern completion engine
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "v0.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- Icons for completion menu
      {
        "nvim-tree/nvim-web-devicons",
        opts = {},
      },
    },
    opts = {
      keymap = {
        preset = "default", -- Use sensible defaults
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true, -- Use familiar styling
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = { enabled = true },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            },
          },
        },
      },
    },
  },
}
