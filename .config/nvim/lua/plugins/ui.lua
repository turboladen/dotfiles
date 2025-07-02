return {
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
          globalstatus = false, -- Per-buffer statuslines (old style)
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
