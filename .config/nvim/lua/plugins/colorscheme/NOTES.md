# Colorscheme Research & Notes

## Current Setup

- **Active**: nightfox (from EdenEast/nightfox.nvim)
- **Settings**: dim_inactive, colorblind-friendly, italic comments/keywords, bold+italic types

## Tested & Configured Colorschemes

### nightfox.nvim (EdenEast/nightfox.nvim) ✅ CURRENT

- **Variants**: nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
- **Configuration**:
  ```lua
  dim_inactive = true,
  colorblind = { enable = true },
  styles = { comments = "italic", keywords = "italic", types = "italic,bold" }
  ```
- **Testing Notes**: Great out-of-the-box experience, colorblind settings work well, good contrast
  ratios, terminal integration seamless
- **Status**: ✅ Currently active and well-configured

### gruvbox.nvim (ellisonleao/gruvbox.nvim)

- **Configuration**: `dim_inactive = true`
- **Testing Notes**: Time-tested, excellent readability, retro groove colors
- **Status**: 🔧 Previously configured, good fallback option

### everforest (sainnhe/everforest)

- **Configuration**:
  ```lua
  -- background = "hard" (commented out)
  italics = true,
  ui_contrast = "high",
  dim_inactive_windows = true,
  diagnostic_line_highlight = true,
  spell_foreground = true,
  -- inlay_hints_background = "dimmed" (commented out)
  ```
- **Testing Notes**: Green-based, easy on eyes, good for long coding sessions
- **Status**: 🔧 Previously configured

### kanagawa.nvim (rebelot/kanagawa.nvim)

- **Configuration**: `compile = true, dimInactive = true`
- **Testing Notes**: Japanese art inspired, warm color palette, unique aesthetic
- **Status**: 🔧 Previously configured

### modus-themes.nvim

- **Configuration**: `dim_inactive = true`
- **Testing Notes**: Accessibility-focused themes
- **Status**: 🔧 Previously configured

### tokyonight.nvim (folke/tokyonight.nvim)

- **Configuration**: `dim_inactive = true, lualine_bold = true`
- **Testing Notes**: Popular, excellent plugin integrations, great defaults
- **Status**: 🔧 Previously configured

### bamboo.nvim

- **Configuration**:
  ```lua
  dim_inactive = true,
  ending_tildes = true,
  lualine = { transparent = true },
  diagnostics = { darker = true }
  ```
- **Testing Notes**: Nature-inspired theme
- **Status**: 🔧 Previously configured

### sonokai (sainnhe/sonokai)

- **Configuration**:
  ```lua
  vim.g.sonokai_style = "shusia"  -- also tried "espresso"
  vim.g.sonokai_better_performance = 1
  vim.g.sonokai_dim_inactive_windows = 1
  ```
- **Testing Notes**: Good performance optimizations, multiple style variants
- **Status**: 🔧 Previously configured

## Tested But Discarded

### 🚫 Problematic Themes

#### collaterlie-nvim (kordyte/collaterlie-nvim)

- **Dark**: N/A
- **Light**: Comment highlighting is super bright; can't read against light background
- **Status**: ❌ Discarded - readability issues

#### oxocarbon.nvim (nyoom-engineering/oxocarbon.nvim)

- **Testing Notes**: Too dark overall; can barely see comments and line numbers
- **Status**: ❌ Discarded - visibility issues

#### gruvbox-baby (luisiacc/gruvbox-baby)

- **Features**: Has lualine support, telescope theme
- **Testing Notes**: Too dark overall; can barely see comments and line numbers
- **Status**: ❌ Discarded - visibility issues

#### cold.nvim (gmr458/cold.nvim)

- **Dark**: Ok, muted, but hard to read comments
- **Light**: N/A
- **Status**: ❌ Discarded - comment readability

#### inspired-github.vim (mvpopuk/inspired-github.vim)

- **Dark**: N/A
- **Light**: Too flat
- **Features**: Has tmux, lualine themes
- **Status**: ❌ Discarded - insufficient contrast

#### sweetie.nvim (NTBBloodbath/sweetie.nvim)

- **Dark**: Decent, nothing special
- **Light**: Almost great, but cursor gets lost
- **Configuration Tried**: `vim.g.sweetie = { cursor_color = false }`
- **Status**: ❌ Discarded - cursor visibility issues

### 🤔 Mixed Results

#### rose-pine.nvim (rose-pine/neovim)

- **Dark**: The 'moon' version is slightly reddish and ok, but not compelling enough
- **Light**: Way too flat to be usable
- **Configuration Tried**: `variant = "dawn", dim_inactive_windows = true`
- **Status**: 🤷 Not compelling enough

#### zenbones.nvim (zenbones-theme/zenbones.nvim)

- **Features**: forestbones variant is nice
- **Issues**: lush.nvim dependency gets in the way of other colorschemes, vimscript config is
  annoying
- **Configuration Tried**:
  ```lua
  vim.g.zenbones_compat = 1
  vim.g.forestbones = {
    solid_line_nr = true,
    darken_noncurrent_window = true,
    colorize_diagnostic_underline_text = true
  }
  ```
- **Status**: 🤷 Good light scheme but dependency issues

#### onehalf (sonph/onehalf)

- **Testing Notes**: Got for light colorscheme, old school neovim wouldn't recognize it, copied .vim
  file to colors/ dir manually
- **Potential**: Could be nice to update and make current, _almost_ great
- **Status**: 🤷 Needs modernization

#### onenord.nvim (rmehri01/onenord.nvim)

- **Configuration**: `fade_nc = true, disable = { eob_lines = false }`
- **Testing Notes**: Like this for light colorscheme
- **Status**: 🤷 Decent light option

#### leaf.nvim (daschw/leaf.nvim)

- **Dark**: Nothing special
- **Light**: Not bad, but not quite enough contrast, even in "high" mode
- **Configuration**: `contrast = "high"`
- **Status**: 🤷 Insufficient contrast

#### melange-nvim (savq/melange-nvim)

- **Dark**: Not bad--not too bright and red-leaning
- **Light**: Not enough contrast
- **Status**: 🤷 Contrast issues in light mode

#### mini.hues (echasnovski/mini.hues)

- **Dark**: N/A
- **Light**: Meh. Next to 0 highlighting
- **Status**: 🤷 Insufficient highlighting

#### nvim-colors-tone (cseelus/nvim-colors-tone)

- **Dark**: Simple, not bad
- **Light**: Too muted
- **Status**: 🤷 Inconsistent across variants

#### nvim-solar-paper (SebastianZaha/nvim-solar-paper)

- **Dark**: Meh. Simple. Pretty contrasty (not in a good way)
- **Light**: Blue/grey background (not bad), but other highlighting is one-note
- **Status**: 🤷 Mixed contrast quality

#### forest.nvim (Skullamortis/forest.nvim)

- **Dark**: VERY green text on black; kinda retro, dig it but maybe not practical
- **Light**: Bluish active background, white inactive. Tough to see highlighting
- **Configuration**: `dim_inactive = true, lualine_bold = true`
- **Status**: 🤷 Novelty over practicality

#### mountaineer.vim (TheNiteCoder/mountaineer.vim)

- **Testing Notes**: Pretty good dark themes, but can't see line numbers. Light theme might be too
  flat
- **Status**: 🤷 Line number visibility issues

#### onedarkpro.nvim (olimorris/onedarkpro.nvim)

- **Features**: Atom's One Dark theme, cacheable, fully customizable, Tree-sitter and LSP support
- **Configuration**: Extensive plugin disabling, `highlight_inactive_windows = true`
- **Status**: 🤷 Over-engineered for needs

#### mellifluous.nvim (ramojus/mellifluous.nvim)

- **Testing Notes**: Got for light theme, bit on the grey side--maybe too much?
- **Configuration**: `neutral = false, bg_contrast = "hard", dim_inactive = true`
- **Status**: 🤷 Too grey

#### toast.vim (jsit/toast.vim)

- **Dark**: Meh
- **Light**: Got it for this; red/browns
- **Issues**: Lose cursor too easily
- **Status**: 🤷 Cursor visibility issues

## Key Findings

### Essential Features:

- **dim_inactive** - Must have for focus
- **Good comment readability** - Many themes fail here
- **Cursor visibility** - Surprisingly common issue
- **Line number visibility** - Often overlooked but critical

### Light Theme Challenges:

- Many light themes lack sufficient contrast
- Comment highlighting often problematic
- Cursor visibility frequently an issue
- Background color balance (not too flat, not too harsh)

### Dark Theme Challenges:

- Some too dark (comments/line numbers invisible)
- Over-contrast can be jarring
- Need good diagnostic color differentiation

### Plugin Integration Priorities:

- Lualine support (bold text preference)
- Tree-sitter highlighting quality
- LSP diagnostic colors
- Terminal color consistency
- Telescope integration

## Current Preferences:

- **Primary**: nightfox (excellent all-around)
- **Backup Dark**: gruvbox, kanagawa, everforest
- **Light Options**: dayfox, forestbones (if dependency issues resolved)
- **Avoid**: Anything with cursor visibility or comment readability issues

## Settings to Always Include:

- `dim_inactive = true` (or equivalent)
- Italic comments when possible
- Bold lualine when supported
- High contrast options when available
