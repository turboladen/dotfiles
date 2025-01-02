return {

  -- Dark: Ok. Very blue
  -- Light: Fantastic. Great contrast.
  -- Comments: In light mode, when cursor is on a word, the background is so
  -- dark that it's almost impossible to read the text underneath. This would be
  -- a top theme if not for that. Maybe it's fixable?
  -- Rocks: yes
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = true
    }
  },

  -- ╭─────────────────────────────────────────────╮
  -- │ Lua port of the most famous vim colorscheme │
  -- ╰─────────────────────────────────────────────╯
  -- Rocks: yes
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = true,
    }
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ High Contrast & Vivid Color Scheme based on Monokai Pro │
  -- ╰─────────────────────────────────────────────────────────╯
  -- Rocks: yes
  {
    "sainnhe/sonokai",
    event = "VeryLazy",
    config = function()
      vim.g.sonokai_style = "shusia"
      -- vim.g.sonokai_style = "espresso"
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_dim_inactive_windows = 1
    end
  },

  -- ╭────────────────────────────────────────────────────────────────────────╮
  -- │ 🦊A highly customizable theme for vim and neovim with support for lsp, │
  -- │ treesitter and a variety of plugins.                                   │
  -- ╰────────────────────────────────────────────────────────────────────────╯
  -- Rocks: yes
  {
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        dim_inactive = true,
        colorblind = {
          enable = true
        },
        styles = {
          comments = "italic",
          keywords = "italic",
          types = "italic,bold",
        }
      },
    },
  },

  -- ╭────────────────────────────────────────────╮
  -- │ A Lua port of the Everforest colour scheme │
  -- ╰────────────────────────────────────────────╯
  -- Dark: Wonderful and greenish
  -- Light: Background is yellowish (nice). With `background=hard`, text is pretty washed out
  -- against the background. This gets better with different settings.
  -- Rocks: yes
  {
    "neanias/everforest-nvim",
    version = false,
    -- lazy = false,
    -- priority = 1000,
    event = "VeryLazy",
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

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │ NeoVim dark colorscheme inspired by the colors of the famous             │
  -- │ painting by Katsushika Hokusai.                                          │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  -- Dark: Not too bright; good for when eyes are tired & I'm squinting.
  -- Light: Crazy yellow everywhere. Tough to see/find cursor.
  -- Rocks: yes
  {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
    opts = {
      compile = true,
      dimInactive = true
    }
  },

  -- I got this for a light color theme.
  -- Dark: N/A
  -- Light: Background is grey-ish, which is fine, but takes away from contrast
  -- a tad. Would be nice to use as a base for customization.
  -- Rocks: yes
  {
    "yorik1984/newpaper.nvim",
    event = "VeryLazy",
    -- lazy = false,
    -- priority = 1000,
  },

  -- I got this for its light colorscheme ("day"), but it's a little on the blue
  -- side; not sure if I like it for that.
  -- Rocks: yes
  {
    "folke/tokyonight.nvim",
    -- lazy = false,
    -- priority = 1000,
    event = "VeryLazy",
    opts = {
      dim_inactive = true,
      lualine_bold = true
    },
  },

  -- I got this for a light colorscheme, which I do like, but it's a tad basic.
  -- Could maybe be really nice if I customized it to my liking. Also not a bad
  -- idea since the owner has deprecated it.
  -- Rocks: yes
  {
    "yorickpeterse/vim-paper",
    event = "VeryLazy",
  },

  -- I got this for a light colorscheme ("lux" (a little too yellow?), "lilac"
  -- (a little too blue?), "hibernus"), which they're all decent, but just a bit
  -- too on the blue side of things and not contrast-y enough.
  -- Rocks: yes
  {
    'talha-akram/noctis.nvim',
    event = "VeryLazy",
  },


  -- Got this for the light theme. It's great!
  -- Rocks: yes
  {
    "ribru17/bamboo.nvim",
    event = "VeryLazy",
    -- lazy = false,
    -- priority = 1000,
    opts = {
      dim_inactive = true,
      ending_tildes = true,
      lualine = {
        transparent = true
      },
      diagnostics = {
        darker = true
      }
    }
  },

  -- Pretty good for a light theme
  -- Rocks: yes
  {
    "mkarmona/materialbox",
    event = "VeryLazy",
  },


  -- Has dark theme, but light theme is decent.
  -- Rocks: yes
  {
    "owickstrom/vim-colors-paramount",
    event = "VeryLazy",
  },

  -- Light: Pretty good light color scheme.
  -- Comments: Has lualine integration.
  -- Rocks: yes
  {
    "Verf/deepwhite.nvim",
    event = "VeryLazy",
    opts = {
      low_blue_light = true
    }
  },

  -- Dark: nice and green/red.
  -- Light: so flat, it's unusable.
  -- Rocks: yes
  {
    "projekt0n/caret.nvim",
    event = "VeryLazy",
  },

  -- Dark theme: good.
  -- Light theme: N/A.
  -- Comments: Leans toward red and yellow--maybe too much? But totally nice and
  -- usable.
  -- Rocks: yes
  {
    "sebasruiz09/fizz.nvim",
    event = "VeryLazy",
  },

  -- Dark: N/A
  -- Light: Good. Just enough contrast on off-white background.
  -- Comments: No bells & whistles.
  -- Rocks: yes
  {
    "dericktseng/balance-theme.nvim",
    event = "VeryLazy"
  },

  -- Dark: Pretty average; not bad.
  -- Light: Pretty good! Enough contrast and color to make it usable.
  -- Comments: With there was inactive pane dimming.
  -- Rocks: yes
  {
    "e-q/okcolors.nvim",
    name = "okcolors",
    event = "VeryLazy"
  },
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
