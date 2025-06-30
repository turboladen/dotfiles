# Colorscheme Research & Notes

## Desired Capabilities

### "dim inactive"

I like to dim inactive buffers so it's clear where I'm working.

### Colorblind Friendly

I've noticed that these types of themes are usually easier on my eyes. This isn't a must-have, just
nice to have.

### Font Capabilities

It's nice when themes take advantage of italics and bold fonts.

### NO `lush.nvim`

Every colorscheme I've used that uses `lush.nvim` gets weird. Don't want.

## Tested & Configured Colorschemes

### nightfox.nvim

- **Repo**: EdenEast/nightfox.nvim
- **Testing Notes**:
  - Great out-of-the-box experience, colorblind settings work well, good contrast ratios, terminal
    integration seamless.
  - **Dark**: Great options
  - **Light**: Great options

### gruvbox.nvim

- **Repo**: ellisonleao/gruvbox.nvim
- **Testing Notes**:
  - Time-tested, excellent readability, retro groove colors
  - Has `dim_inactive`
  - **Dark**:
  - **Light**:

### everforest.nvim

- **Repo**: `neanias/everforest-nvim`
- **Testing Notes**:
  - Green-based, easy on eyes, good for long coding sessions
  - **Dark**:
  - **Light**:

### kanagawa.nvim

- **Repo**: `rebelot/kanagawa.nvim`
- **Testing Notes**:
  - Japanese art inspired, warm color palette, unique aesthetic
  - Has `dimInactive`
  - **Dark**:
  - **Light**:

### modus-themes.nvim

- **Repo**: `miikanissi/modus-themes.nvim`
- **Testing Notes**:
  - Accessibility-focused themes
  - Has `dim_inactive`
  - **Dark**:
  - **Light**:

### tokyonight.nvim

- **Repo**: `folke/tokyonight.nvim`
- **Testing Notes**:
  - Popular, excellent plugin integrations, great defaults
  - Has `dim_inactive`
  - **Dark**:
  - **Light**:

### bamboo.nvim

- **Repo**: `ribru17/bamboo.nvim`
- **Testing Notes**:
  - Nature-inspired theme
  - Has `dim_inactive`
  - **Dark**:
  - **Light**:

### sonokai

- **Repo**: `sainnhe/sonokai`
- **Testing Notes**:
  - Good performance optimizations, multiple style variants
  - Had weird behavior at times
  - Has `sonokai_dim_inactive_windows`
  - **Dark**: "shusia" was my fave; next was "espresso"
  - **Light**:

## Extra Colorschemes (Testing)

### balance-theme.nvim

- **Repo**: `dericktseng/balance-theme.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### caret.nvim

- **Repo**: `projekt0n/caret.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### deepwhite.nvim

- **Repo**: `verf/deepwhite.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### fizz.nvim

- **Repo**: `sebasruiz09/fizz.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### materialbox

- **Repo**: `mkarmona/materialbox`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### newpaper.nvim

- **Repo**: `yorik1984/newpaper.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### noctis.nvim

- **Repo**: `talha-akram/noctis.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### okcolors.nvim

- **Repo**: `e-q/okcolors.nvim`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### vim-paper

- **Repo**: `yorickpeterse/vim-paper`
- **Testing Notes**:
  - _To be filled_
  - **Dark**:
  - **Light**:

### vim-colors-paramount

- **Repo**: `owickstrom/vim-colors-paramount`
- **Testing Notes**:
  - _To be filled_
  - Note: This is a vim colorscheme, may need manual dim_inactive setup
  - **Dark**:
  - **Light**:

---

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
