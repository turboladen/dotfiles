-- Filetype detection for Tiltfile and Starlark files

vim.filetype.add({
  filename = {
    ["Tiltfile"] = "tiltfile",
    ["tiltfile"] = "tiltfile",
  },
  pattern = {
    [".*%.tiltfile$"] = "tiltfile",
    [".*%.star$"] = "starlark",
    [".*%.bzl$"] = "starlark",
  },
})
