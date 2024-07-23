local function strip_tabs()
  vim.opt_local.expandtab = true
  vim.cmd("retab")
end

-- https://www.nerdfonts.com/cheat-sheet
-- local nf_md_close_octagon_outline = "󰅝 "
-- local nf_oct_info = " "
-- local nf_oct_light_bulb = " "

local nf_cod_error = " "
local nf_cod_warning = " "
local nf_cod_info = " "
local nf_cod_lightbulb = ""

local lsp_diagnostic_signs = {
  Error = nf_cod_error,
  Info = nf_cod_info,
  Hint = nf_cod_lightbulb,
  Warn = nf_cod_warning,
}

return {
  lsp_diagnostic_signs = lsp_diagnostic_signs,
  strip_tabs = strip_tabs
}
