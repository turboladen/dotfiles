-- Filetype detection for Tiltfile

vim.filetype.add({
  filename = {
    ["Tiltfile"] = "tiltfile",
    ["tiltfile"] = "tiltfile",
  },
})
