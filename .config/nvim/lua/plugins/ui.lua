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
  --     -- "rcarriga/nvim-notify",
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
  --
  -- ╭────────────────────────────────────────────────────────╮
  -- │ Neovim plugin to improve the default vim.ui interfaces │
  -- ╰────────────────────────────────────────────────────────╯
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {}
  },

  -- ╭─────────────────────────────────────╮
  -- │ A neovim port of Assorted Biscuits. │
  -- ╰─────────────────────────────────────╯
  {
    "code-biscuits/nvim-biscuits",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = false,
    event = "VeryLazy",
    opts = function()
      -- local icon = ""
      local icon = "✨"

      return {
        toggle_keybind = "<leader>cb",
        show_on_start = true,
        cursor_line_only = true,
        default_config = {
          max_distance = 25,
          prefix_string = " " .. icon .. " ",
        }
      }
    end
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Prismatic line decorations for the adventurous vim user │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    event = "VeryLazy",
    config = function()
      require("modes").setup()
    end
  },

  -- ╭──────────────────────────────────╮
  -- │ 🌟 Terminal manager for (neo)vim │
  -- ╰──────────────────────────────────╯
  {
    "voldikss/vim-floaterm",
    enabled = false,
    keys = {
      { "<leader>ww", CustomOpenFloaterm, desc = "Open a floating term" },
    },
    init = function()
      vim.g.floaterm_already_opened = false
    end,
  },

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ A blazing fast and easy to configure neovim statusline plugin written        │
  -- │  in pure lua.                                                                │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'stevearc/aerial.nvim',
    },
    opts = function()
      -- ╭───────────────────────────────────────────────────────────────────────────────────────────╮
      -- │ Bubbles config for lualine                                                                │
      -- │ Author: lokesh-krishna                                                                    │
      -- │ MIT license, see LICENSE for more details.                                                │
      -- │ https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua#enroll-beta │
      -- ╰───────────────────────────────────────────────────────────────────────────────────────────╯
      -- bubbly.nvim colors
      local colors = {
        blue = "#6cb6eb",
        cyan = "#5dbbc1",
        black = "#3e4249",
        black2 = "#111111",
        white = "#c5cdd9",
        red = "#ec7279",
        violet = "#d38aea",
        lightgrey = "#57595e",
        darkgrey = "#404247",
        darkorange = "#844212"
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.lightgrey },
          c = { fg = colors.black, bg = colors.darkgrey },
        },
        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },
        inactive = {
          a = { fg = colors.white, bg = colors.darkgrey },
          b = { fg = colors.white, bg = colors.darkgrey },
          c = { fg = colors.black, bg = colors.darkgrey },
        },
      }

      return {
        options = {
          theme = bubbles_theme,
          component_separators = "󰇙",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = {
            { 'branch', color = { bg = colors.darkorange } },
            { 'diff', separator = { right = "" }, color = { bg = "#000000" } },
            { 'filename', path = 1, separator = { right = "" } },
          },
          lualine_c = { 'tabs' },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = {
            { 'filename', path = 1 },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = { "aerial", "quickfix", "trouble" },
      }
    end
  },



  -- ╭──────────────────────────────────────────╮
  -- │ Show vertical line for indentation level │
  -- ╰──────────────────────────────────────────╯
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "┊",
        highlight = "LineNr",
      },
      exclude = {
        filetypes = {
          "Trouble",
          "help",
          "lazy",
          "lua",
          "mason",
          "notify",
          -- "ruby",
          -- "rust",
        },
      },
      -- char = "┊",
      -- char_highlight = "LineNr",
      -- buftype_exclude = { "terminal", "nofile" },
      -- filetype_exclude = {
      --   "Trouble",
      --   "help",
      --   "lazy",
      --   "lua",
      --   "mason",
      --   "notify",
      --   "ruby",
      --   "rust",
      -- },
      --
      -- space_char_blankline = " ",
      -- show_current_context = true,
      -- show_current_context_start = true,
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
    init = function()
      vim.opt.list = true
    end
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Icon set using nonicons for neovim plugins and settings │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "yamatsum/nvim-nonicons",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    -- config = function(_, opts)
    --   require('nvim-nonicons').setup(opts)
    -- end
  },
  -- ╭─────────────────────────────╮
  -- │ Extensible Neovim Scrollbar │
  -- ╰─────────────────────────────╯
  {
    "petertriho/nvim-scrollbar",
    enabled = false,
    -- event = "VeryLazy",
    opts = {},
  },

  {
    'Bekaboo/dropbar.nvim',
    enabled = false,
    opts = {}
  },

  {
    "SmiteshP/nvim-navbuddy",
    enabled = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
    opts = {
      -- lsp = {
      --   auto_attach = true
      -- }
    },
    -- config = function(_, opts)
    --   require('nvim-navbuddy').setup(opts)
    -- end
    -- keys = {
    --   { "<leader>cn", function() require("nvim-navbuddy").open() end, desc = "Navbuddy" }
    -- }
  }
}
