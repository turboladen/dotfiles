--  ╭────────────────────────────────────────────────────────────╮
--  │ A neovim plugin that helps managing crates.io dependencies │
--  ╰────────────────────────────────────────────────────────────╯
local Plugin = { "saecki/crates.nvim" }

Plugin.tag = "v0.4.0"
Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.event = { "BufRead Cargo.toml" }
Plugin.lazy = true
Plugin.init = function()
  local crates_group = vim.api.nvim_create_augroup("crates", {})

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = "toml",
    group = crates_group,
    command = "nnoremap <silent> K :lua require('crates').show_popup()<CR>"
  })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = 'Cargo.toml',
    group = crates_group,
    callback = function(ev)
      local function opts(desc)
        return {
          buffer = ev.buf,
          desc = desc
        }
      end

      -- vim.keymap.set('n', '<leader>ct', "<cmd>lua require('crates').toggle<cr>", opts("crates: enable/disable info"))
      vim.keymap.set('n', '<leader>ct', require('crates').toggle, opts("crates: enable/disable info"))
      vim.keymap.set('n', '<leader>cu', require('crates').upgrade_crate, opts("crates: update current"))
      vim.keymap.set('n', '<leader>cl', require('crates').upgrade_all_crates, opts("crates: update all"))
    end
  })
end

Plugin.config = function()
  require("crates").setup()
end

Plugin.keys = function()
  local crates = require("crates")

  return {
    -- { "<leader>ct", crates.toggle,              desc = "crates: enable/disable info" },
    { "<leader>cr", crates.reload,              desc = "crates: reload cache" },
    { "<leader>cv", crates.show_versions_popup, desc = "crates: details w/version info" },
    { "<leader>cf", crates.show_features_popup, desc = "crates: details w/feature info" },
  }
end

return Plugin
