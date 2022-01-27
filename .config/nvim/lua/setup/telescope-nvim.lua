local telescope = require("telescope")

telescope.setup(
    {
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = require("telescope.actions").close
                }
            }
        },
        pickers = {
            buffers = {
                theme = "cursor",
                previewer = false
            },
            find_files = {
                theme = "dropdown",
                previewer = false
            },
            lsp_code_actions = {
                theme = "cursor",
                layout_config = {height = 15}
            },
            oldfiles = {
                theme = "dropdown"
            }
        }
    }
)

-- telescope-github.nvim
telescope.load_extension("gh")
