-- Notes
-- Whatever colorscheme I'm choosing to set on boot should probably have `priority = 1000`.
--
return {

  -- tokyonight
  -- I got this for its light colorscheme ("day"), but it's a little on the blue
  -- side; not sure if I like it for that.
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
      lualine_bold = true,
    },
  },

  -- ╭─────────────────────────────────────────────╮
  -- │ Lua port of the most famous vim colorscheme │
  -- ╰─────────────────────────────────────────────╯
  {
    "ellisonleao/gruvbox.nvim",
    config = true,
    opts = {
      dim_inactive = true,
    },
  },

  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    config = function()
      require("everforest").setup({
        -- background = "hard",
        italics = true,
        ui_contrast = "high",
        dim_inactive_windows = true,
        diagnostic_line_highlight = true,
        spell_foreground = true,
        -- inlay_hints_background = "dimmed"
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      compile = true,
      dimInactive = true,
    },
  },

  {
    "miikanissi/modus-themes.nvim",
    opts = {
      dim_inactive = true,
    },
  },

  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        dim_inactive = true,
        colorblind = {
          enable = true,
        },
        styles = {
          comments = "italic",
          keywords = "italic",
          types = "italic,bold",
        },
      },
    },
  },

  -- Using lazy.nvim
  {
    "ribru17/bamboo.nvim",
    lazy = false,
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
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ High Contrast & Vivid Color Scheme based on Monokai Pro │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "sainnhe/sonokai",
    init = function()
      vim.g.sonokai_style = "shusia"
      -- vim.g.sonokai_style = "espresso"
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_dim_inactive_windows = 1
    end,
  },
  -- Dark: nice and green/red.
  -- Light: so flat, it's unusable.
  { "projekt0n/caret.nvim" },
  { "dericktseng/balance-theme.nvim" },
  { "verf/deepwhite.nvim" },
  { "sebasruiz09/fizz.nvim" },
  { "mkarmona/materialbox" },
  { "yorik1984/newpaper.nvim" },
  { "talha-akram/noctis.nvim" },

  -- Dark: Pretty average; not bad.
  -- Light: Pretty good! Enough contrast and color to make it usable.
  -- Comments: With there was inactive pane dimming.
  { "e-q/okcolors.nvim" },
  { "yorickpeterse/vim-paper" },
  { "owickstrom/vim-colors-paramount" },
}

-- ╭──────────────────╮
-- │ Discarded themes │
-- ╰──────────────────╯
-- Dark: N/A
-- Light: Comment highlighting is super bright; can't read against the light
-- background.
-- { "kordyte/collaterlie-nvim" },
--------------------------------------------
-- {
--   "nyoom-engineering/oxocarbon.nvim",
--   event = "VeryLazy",
-- },
--------------------------------------------
-- Has lualine support. Too dark overall; can barely see comments and line
-- numbers.
-- {
--   "luisiacc/gruvbox-baby",
--   event = "VeryLazy",
--   init = function()
--     vim.gruvbox_baby_telescope_theme = 1
--   end
-- },
--------------------------------------------
-- Dark theme: Ok, muted. hard to read comments. I want to like it.
-- Light theme: N/A
-- { "gmr458/cold.nvim" }
--
--------------------------------------------
-- Dark: N/A
-- Light: Too flat.
-- Comments: Has tmux, lualine themes.
-- { "mvpopuk/inspired-github.vim" },
--------------------------------------------
-- Dark: Decent. Nothing special.
-- Light: Almost great, but I lose my cursor.
-- {
--   "NTBBloodbath/sweetie.nvim",
--   init = function()
--     vim.g.sweetie = {
--       cursor_color = false
--     }
--   end
-- },
--------------------------------------------
-- Dark: The 'moon' version is slightly reddish and ok, but not enough to make
-- me want to use it.
-- Light: Way too flat to be usable.
-- {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   opts = {
--     variant = "dawn",
--     dim_inactive_windows = true
--   }
-- },
-- I got this for its light colorschemes; forestbones is nice, but I hate how
-- lush.nvim gets in the way of other color schemes; and having to use
-- vimscript for config is annoying.
-- {
--   "zenbones-theme/zenbones.nvim",
--   -- enabled = false,
--   -- Optionally install Lush. Allows for more configuration or extending the colorscheme
--   -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
--   -- In Vim, compat mode is turned on as Lush only works in Neovim.
--   -- dependencies = "rktjmp/lush.nvim",
--   -- lazy = false,
--   -- priority = 1000,
--   config = function(opts)
--     vim.g.zenbones_compat = 1
--     vim.g.forestbones = {
--       solid_line_nr = true,
--       darken_noncurrent_window = true,
--       colorize_diagnostic_underline_text = true
--     }
--   end,
--   -- init = function()
--   -- end
-- },
--
-- I got this for a light colorscheme, but since it's old school neovim
-- wouldn't recognize it, so I just copied the .vim file to my `colors/` dir.
-- Could be nice to update that and make it current; it's *almost* great.
-- {
--   "sonph/onehalf",
--   lazy = false,
--   priority = 1000
-- }

-- I like this for its light colorscheme
-- {
--   'rmehri01/onenord.nvim',
--   event = "VeryLazy",
--   -- lazy = false,
--   -- priority = 1000,
--   opts = {
--     fade_nc = true,
--     disable = {
--       eob_lines = false
--     }
--   }
-- },
-- Dark: Nothing special.
-- Light: Not bad, but not quite enough contrast, even in "high" mode
-- {
--   "daschw/leaf.nvim",
--   opts = {
--     contrast = "high"
--   }
-- }
-- Dark: Not bad--not too bright and red-leaning.
-- Light: Not enough contrast.
-- {
--   "savq/melange-nvim",
-- },

-- Dark: N/A
-- Light: Meh. Next to 0 highlighting.
-- { 'echasnovski/mini.hues',  version = false },

-- Dark: Simple, not bad.
-- Light: Too muted.
-- { "cseelus/nvim-colors-tone" }

-- Dark: Meh. Simple. Pretty constrasty (in a not so good way).
-- Light: Blue/grey background (not bad), but other highlighting is pretty
-- one-note (maybe that's the intention via "paper").
-- {
--   "SebastianZaha/nvim-solar-paper"
-- }

-- Dark: VERY green text on black; kinda retro. I dig, but maybe not super
-- practical.
-- Light: Similar to some others where active background is bluish, inactive
-- is white. Tough to see highlighting like this
-- {
--   "Skullamortis/forest.nvim",
--   opts = {
--     dim_inactive = true,
--     lualine_bold = true
--   }
-- }
-- Pretty good dark themes, but can't see vim numbers. Light theme might be
-- too flat.
-- {
--   "TheNiteCoder/mountaineer.vim",
--   event = "VeryLazy",
-- },
-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ 🎨 Atom's iconic One Dark theme. Cacheable, fully customisable, Tree-sitter │
-- │ and LSP semantic token support. Comes with variants                         │
-- ╰─────────────────────────────────────────────────────────────────────────────╯
-- {
--   "olimorris/onedarkpro.nvim",
--   event = "VeryLazy",
--   config = function()
--     require("onedarkpro").setup({
--       opts = {
--         plugins = {
--           barbar = false,
--           codecompanion = false,
--           copilot = false,
--           dashboard = false,
--           hop = false,
--           neo_tree = false,
--           nvim_bqf = false,
--           nvim_tree = false,
--           startify = false,
--           toggleterm = false,
--           vim_ultest = false,
--           vim_dadbod_ui = false,
--         },
--         options = {
--           cursorline = true,
--           lualine_transparency = true,
--           highlight_inactive_windows = true
--         }
--       }
--     })
--   end
-- },
-- Got for light theme. It's a big on the grey side--maybe too much?
-- {
--   "ramojus/mellifluous.nvim",
--   event = "VeryLazy",
--   opts = {
--     mellifluous = {
--       neutral = false,
--       bg_contrast = "hard",
--     },
--     dim_inactive = true,
--     plugins = {
--       nvim_tree = {
--         enabled = false
--       },
--       neow_tree = {
--         enabled = false
--       },
--       startify = false
--     }
--   }
-- },
-- Dark: Meh.
-- Light: Got it for this; red/browns.
-- Comments: I lose my cursor too easily.
-- {
--   "jsit/toast.vim",
--   event = "VeryLazy",
-- },
--
