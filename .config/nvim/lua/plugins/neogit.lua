local nf_fa_folder = ""
local nf_fa_folder_open = ""

return {
  "TimUntersberger/neogit",
  enabled = false,
  opts = {
    signs = {
      section = { nf_fa_folder, nf_fa_folder_open },
      item = { nf_fa_folder, nf_fa_folder_open }
    }
  }
}
