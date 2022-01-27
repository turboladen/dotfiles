local nf_fa_folder = ""
local nf_fa_folder_open = ""

require("neogit").setup(
    {
        signs = {
            section = {nf_fa_folder, nf_fa_folder_open},
            item = {nf_fa_folder, nf_fa_folder_open}
        }
    }
)
