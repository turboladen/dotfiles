return {
  -- Better UI for vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          winblend = 10,
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
        },
      },
      select = {
        enabled = true,
        backend = { "fzf_lua", "builtin", "nui" },
        trim_prompt = true,
        fzf_lua = {
          winopts = {
            height = 0.5,
            width = 0.5,
          },
        },
        builtin = {
          show_numbers = true,
          border = "rounded",
          relative = "editor",
          buf_options = {},
          win_options = {
            winblend = 10,
            cursorline = true,
            cursorlineopt = "both",
          },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
        },
      },
    },
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Modern, fast statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- Use shared icons for consistency across plugins
      local icons = require("config.icons")

      -- Helper function to get the correct separator based on theme
      local function get_separators()
        return {
          left = "",
          right = "",
        }
      end

      return {
        options = {
          theme = "auto", -- Automatically adapts to colorscheme
          globalstatus = true, -- Per-buffer statuslines (old style)
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
          },
          component_separators = "󰇙",
          section_separators = get_separators(),
        },
        sections = {
          lualine_a = {
            {
              "mode",
              separator = { left = get_separators().right },
              right_padding = 2,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = icons.git.branch,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added .. " ",
                modified = icons.git.modified .. " ",
                removed = icons.git.removed .. " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1, -- Relative path
              symbols = {
                modified = icons.files.modified,
                readonly = icons.files.readonly,
                unnamed = icons.files.unnamed,
                newfile = icons.files.newfile,
              },
            },
          },
          lualine_x = {
            {
              "filetype",
              colored = true,
              icon_only = false,
            },
          },
          lualine_y = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = {
                error = icons.diagnostics.error .. " ",
                warn = icons.diagnostics.warn .. " ",
                info = icons.diagnostics.info .. " ",
                hint = icons.diagnostics.hint .. " ",
              },
              colored = true,
              update_in_insert = false,
            },
            {
              "progress",
              separator = " ",
              padding = { left = 1, right = 0 },
            },
            {
              "location",
              padding = { left = 0, right = 1 },
            },
          },
          lualine_z = {
            {
              function()
                return " " .. os.date("%R")
              end,
              separator = { right = get_separators().left },
              left_padding = 2,
            },
          },
        },
        inactive_sections = {
          lualine_a = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = icons.files.modified,
                readonly = icons.files.readonly,
                unnamed = icons.files.unnamed,
              },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        extensions = { "lazy", "trouble", "quickfix" },
      }
    end,
  },
}
