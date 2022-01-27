require("nvim-treesitter.configs").setup(
    {
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "cpp",
            "css",
            "dockerfile",
            "elixir",
            "elm",
            "glimmer",
            "graphql",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "jsonc",
            "llvm",
            -- "lua",
            "regex",
            "ruby",
            "rust",
            "scss",
            "toml",
            "typescript",
            "vim",
            "yaml"
        },
        highlight = {enable = true},
        incremental_selection = {enable = true},
        -- indent = {enable = true},
        matchup = {enable = true},
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner"
                }
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer"
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer"
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer"
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer"
                }
            }
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
        context_commentstring = {
            enable = true,
            config = {
                rust = {
                    __default = "/// %s",
                    comment = "// %s"
                }
            }
        }
    }
)

-- vim.api.nvim_set_option("foldmethod", "expr")
-- vim.api.nvim_set_option("foldexpr", "nvim_treesitter#foldexpr()")
