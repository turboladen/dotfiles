-- Dependencies to install:
-- taplo: cargo install taplo-cli --locked --features lsp
--
-- Note: No external formatter needed - taplo LSP includes excellent formatting

return {
  -- Treesitter TOML parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "toml" },
    },
  },

  -- TOML LSP configuration with Taplo
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure taplo with schema support
      vim.lsp.config("taplo", {
        settings = {
          taplo = {
            schema = {
              enabled = true,
              catalogs = {
                "https://www.schemastore.org/api/json/catalog.json",
              },
            },
          },
        },
      })

      vim.lsp.enable("taplo")
    end,
  },

  -- Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = false,
          },
        },
      })

      -- Add keymaps when Cargo.toml is opened
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CratesNvimKeymaps", { clear = true }),
        pattern = "*Cargo.toml",
        callback = function()
          local filename = vim.fn.expand("%:t")
          local bufnr = vim.api.nvim_get_current_buf()

          -- Only proceed if this is actually a Cargo.toml file
          if filename ~= "Cargo.toml" then
            return
          end

          -- Check if keymaps are already set for this buffer to prevent duplicates
          local existing_maps = vim.api.nvim_buf_get_keymap(bufnr, "n")
          for _, map in ipairs(existing_maps) do
            if map.desc and map.desc:match("^Crates:") then
              return
            end
          end

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, {
              silent = true,
              buffer = bufnr,
              desc = "Crates: " .. desc,
            })
          end

          -- Toggle and reload
          map("<leader>rt", require("crates").toggle, "Toggle info")
          map("<leader>rr", require("crates").reload, "Reload cache")

          -- Show popups
          map("<leader>rv", require("crates").show_versions_popup, "Show versions")
          map("<leader>rf", require("crates").show_features_popup, "Show features")
          map("<leader>rd", require("crates").show_dependencies_popup, "Show dependencies")

          -- Update and upgrade
          map("<leader>ru", require("crates").update_crate, "Update crate")
          map("<leader>rU", require("crates").upgrade_crate, "Upgrade crate")
          map("<leader>ra", require("crates").update_all_crates, "Update all")
          map("<leader>rA", require("crates").upgrade_all_crates, "Upgrade all")

          -- Extract crate info
          map(
            "<leader>rx",
            require("crates").expand_plain_crate_to_inline_table,
            "Extract to inline table"
          )
          map("<leader>rX", require("crates").extract_crate_into_table, "Extract into table")

          -- Open external links
          map("<leader>rH", require("crates").open_homepage, "Open homepage")
          map("<leader>rR", require("crates").open_repository, "Open repository")
          map("<leader>rD", require("crates").open_documentation, "Open documentation")
        end,
      })
    end,
  },
}
