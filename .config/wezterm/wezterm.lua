local wezterm = require 'wezterm'

local config = wezterm.config_builder()

--  ╭─────────────╮
--  │ Core things │
--  ╰─────────────╯
-- https://wezfurlong.org/wezterm/config/lua/config/term.html
config.term = 'wezterm'
config.color_scheme = 'nightfox'
-- font = wezterm.font({ family = 'MonoLisaCustom Nerd Font' })
config.font = wezterm.font({ family = 'MonoLisa' })
config.font_size = 13.0
config.native_macos_fullscreen_mode = true
config.dpi = 144.0
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = true

-- https://wezfurlong.org/wezterm/config/lua/keyassignment/SwitchWorkspaceRelative.html
wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

--  ╭───────╮
--  │ Binds │
--  ╰───────╯
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = {
  mods = 'CTRL',
  key = 'a',
  timeout_milliseconds = 1000,
}

config.keys = {
  {
    key = 'l',
    mods = 'SUPER',
    action = wezterm.action.ShowLauncher,
  },
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

  --  ╭──────────────────────╮
  --  │ Workspace management │
  --  ╰──────────────────────╯
  {
    mods = 'LEADER',
    key = 's',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  {
    key = 'n', mods = 'CTRL', action = wezterm.action.SwitchWorkspaceRelative(1)
  },
  {
    key = 'p', mods = 'CTRL', action = wezterm.action.SwitchWorkspaceRelative(-1)
  },
}

return config
