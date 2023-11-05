local wezterm = require 'wezterm'

local config = {
  --  ╭─────────────╮
  --  │ Core things │
  --  ╰─────────────╯
  -- https://wezfurlong.org/wezterm/config/lua/config/term.html
  term = 'wezterm',
  color_scheme = 'nightfox',
  -- font = wezterm.font({ family = 'MonoLisaCustom Nerd Font' }),
  font = wezterm.font({ family = 'MonoLisa Custom' }),
  font_size = 13.0,
  native_macos_fullscreen_mode = true,
  -- dpi = 144.0,
  use_fancy_tab_bar = false,

  --  ╭───────╮
  --  │ Binds │
  --  ╰───────╯
  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = {
    mods = 'CTRL',
    key = 'a',
    timeout_milliseconds = 1000,
  },
  keys = {
    {
      mods = 'LEADER|SHIFT',
      key = '|',
      action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain',
      },
    },
    {
      mods = 'LEADER|SHIFT',
      key = '"',
      action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain',
      },
    },
    --  ╭────────────────────╮
    --  │ Switch active pane │
    --  ╰────────────────────╯
    {
      mods = 'LEADER|SHIFT',
      key = 'h',
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
      mods = 'LEADER|SHIFT',
      key = 'j',
      action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
      mods = 'LEADER|SHIFT',
      key = 'k',
      action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
      mods = 'LEADER|SHIFT',
      key = 'l',
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
  }
}

return config
