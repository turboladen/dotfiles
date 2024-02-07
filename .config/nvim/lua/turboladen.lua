local function strip_tabs()
  vim.opt_local.expandtab = true
  vim.cmd("retab")
end

---Make an adapted box with left-aligned text, then format.
--
---@param style number
local function al_box(style)
  require("comment-box").albox(style)
  vim.lsp.buf.format({ async = false })
end

---Make an centered box with centered text, then format. Good for file headers.
--
---@param style number
local function cc_box(style)
  style = style or 3
  require("comment-box").ccbox(style)
  vim.lsp.buf.format({ async = false })
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
  al_box = al_box,
  cc_box = cc_box,
  lsp_diagnostic_signs = lsp_diagnostic_signs,
  strip_tabs = strip_tabs
}
