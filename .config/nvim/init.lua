-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                                                              │
-- │                                   init.lua                                   │
-- │                                                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local rocks_config = {
  rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
  -- Remove the dylib and dll paths if you do not need macos or windows support
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

-- wth can't I call this in the config file??
require("hlslens").setup()





local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.variables')
load('user.options')
load('user.commands')
-- require('user.lazy_init')

load('user.keymaps')

-- vim.opt.background = 'dark'
-- -- pcall(vim.cmd.colorscheme, 'duskfox')
-- pcall(vim.cmd.colorscheme, 'kanagawa')
-- -- pcall(vim.cmd.colorscheme, 'everforest')
-- -- pcall(vim.cmd.colorscheme, 'nightfox')
-- -- pcall(vim.cmd.colorscheme, 'gruvbox')

-- -- vim.opt.background = 'light'
-- -- pcall(vim.cmd.colorscheme, 'bamboo')
-- -- pcall(vim.cmd.colorscheme, 'dayfox')
-- -- pcall(vim.cmd.colorscheme, 'noctis_lilac')
-- -- pcall(vim.cmd.colorscheme, 'paper')
-- -- pcall(vim.cmd.colorscheme, 'forestbones')
-- -- pcall(vim.cmd.colorscheme, 'onehalflight')
-- -- pcall(vim.cmd.colorscheme, 'newpaper')
-- -- pcall(vim.cmd.colorscheme, 'tokyonight-day')

-- Rg2 = function(arg)
--   local output = require("init_rs").ripgrep.rg_to_quick_fix(arg.fargs[1])
--   vim.api.nvim_call_function("setqflist", { output })
--   vim.api.nvim_command("copen")
-- end

-- vim.api.nvim_create_user_command("Rg2", Rg2, { nargs = 1 })

vim.api.nvim_create_user_command(
  "SetLightScheme",
  function(opts)
    vim.cmd.colorscheme(opts.fargs[1])
    vim.opt_global.background = 'light'
  end,
  {
    desc = "Set to a light colorscheme",
    force = true,
    nargs = 1,
  }
)

vim.api.nvim_create_user_command(
  "LightSchemes",
  function()
    local schemes = {
      "balance",
      "caret",
      "bamboo",
      "dayfox",
      "dawnfox",
      "everforest",
      "kanagawa-lotus",
      "gruvbox",
      "materialbox",
      "modus",
      "modus_operandi",
      "newpaper",
      "noctis_lux",
      "noctis_hibernus",
      "noctis_lilac",
      "okcolors",
      "paramount",
      "paper",
      "tokyonight-day",
    }
    print(vim.inspect(schemes))
  end,
  {
    desc = "List light colorschemes",
    force = true,
    nargs = 0,
  }
)

vim.api.nvim_create_user_command(
  "SetDarkScheme",
  function(opts)
    vim.cmd.colorscheme(opts.fargs[1])
    vim.opt_global.background = 'dark'
  end,
  {
    desc = "Set to a dark colorscheme",
    force = true,
    nargs = 1,
  }
)

vim.api.nvim_create_user_command(
  "DarkSchemes",
  function()
    local schemes = {
      "duskfox",
      "nordfox",
      "terafox",
      "nightfox",
      "everforest",
      "sonokai",
      "gruvbox",
      "caret",
      "fizz",
      "kanagawa",
      "kanagawa-wave",
      "kanagawa-dragon",
      "materialbox",
      "modus_vivendi",
      "noctis",
      "noctis_sereno",
      "noctis_obscuruo",
      "noctis_azureus",
      "noctis_bordo",
      "noctis_uva",
      "noctis_minimus",
      "noctis_viola",
      "okcolors",
      "paramount",
      "tokyonight",
      "tokyonight-moon",
      "tokyonight-night",
      "tokyonight-storm",
    }
    print(vim.inspect(schemes))
  end,
  {
    desc = "List light colorschemes",
    force = true,
    nargs = 0,
  }
)

-- require("init_rs")
-- vim.o.completefunc = "v:lua.require'init_rs'.regex_buffer_completer"
