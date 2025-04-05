-- ╭──────╮
-- │ Rust │
-- ╰──────╯
vim.g.rustaceanvim = {
  tools = {
    inlay_hints = {
      only_current_line = true,
    },
  },
  server = {
    on_attach = function(_client, _bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        completion = {
          capable = { snippets = "add_parenthesis" }
        },
        assist = {
          emitMustUse = true,
        },
        cargo = {
          features = "all",
        },
        -- checkOnSave = {
        --   command = "clippy",
        -- },
        inlayHints = {
          closureCaptureHints = {
            enable = true,
          },
          lifetimeElisionHints = {
            enable = true,
          },
          rangeExclusiveHints = {
            enable = true,
          },
        },
        lens = {
          references = {
            adt = {
              enable = true,
            },
            enumVariant = {
              enable = true,
            },
            method = {
              enable = true,
            },
            trait = {
              enable = true,
            },
          },
        },
        -- typing = {
        --   autoClosingAngleBrackets = {
        --     enable = true
        --   }
        -- }
      },
    },
  },
  -- dap = {}
}
--  ╭────────────────────────────────────────────────────────────╮
--  │ A neovim plugin that helps managing crates.io dependencies │
--  ╰────────────────────────────────────────────────────────────╯
-- local Plugin = { "saecki/crates.nvim" }
--
-- Plugin.tag = "stable"
-- Plugin.event = { "BufRead Cargo.toml", "BufRead *.rs" }
-- Plugin.lazy = true
--
-- Plugin.config = function()
--   require("crates").setup({
--     lsp = {
--       enabled = true,
--       on_attach = function(_, bufnr)
--         require("user.keymaps").crates(bufnr)
--       end,
--       actions = true,
--       completion = true,
--       hover = true
--     }
--   })
-- end
--
-- return Plugin
require("crates").setup({
  lsp = {
    enabled = true,
    -- on_attach = function(_, bufnr)
    --   require("user.keymaps").crates(bufnr)
    -- end,
    actions = true,
    completion = true,
    hover = true
  }
})
