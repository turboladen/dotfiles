function CustomOpenFloaterm()
  if vim.g.floaterm_already_opened then
    vim.cmd("FloatermToggle myfloat")
  else
    vim.g.floaterm_already_opened = true
    vim.cmd("FloatermNew --wintype=split --height=20 --position=botright --autoclose=2 --name=myfloat zsh")
  end
end

return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ 💥 Highly experimental plugin that completely           │
  -- │ replaces the UI for messages, cmdline and the popupmenu.│
  -- ╰─────────────────────────────────────────────────────────╯
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- cmdline = {
  --     --   view = "cmdline",
  --     -- },
  --     lsp = {
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true,         -- use a classic bottom cmdline for search
  --       -- command_palette = true,       -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false,           -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false,       -- add a border to hover docs and signature help
  --     },
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --     -- {
  --     --   "rcarriga/nvim-notify",
  --     --   dependencies = {
  --     --     "yamatsum/nvim-nonicons",
  --     --   },
  --     --   init = function()
  --     --     vim.opt.termguicolors = true
  --     --   end,
  --     --   opts = {
  --     --     timeout = 3000,
  --     --     icons = require("nvim-nonicons.extentions.nvim-notify").icons
  --     --   },
  --     -- },
  --   }
  -- },

  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    opts = {},
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Icon set using nonicons for neovim plugins and settings │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
