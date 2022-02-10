require("nvim-treesitter.configs").setup({
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
        "lua",
        "regex",
        "ruby",
        "rust",
        "scss",
        "toml",
        "typescript",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
        disable = { "lua" },
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    -- https://github.com/andymass/vim-matchup
    matchup = { enable = true, disable = { "rust" } },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    context_commentstring = {
        enable = true,
        config = {
            rust = {
                __default = "// %s",
                comment = "// %s",
            },
        },
    },
})

-- vim.api.nvim_set_option("foldmethod", "expr")
-- vim.api.nvim_set_option("foldexpr", "nvim_treesitter#foldexpr()")
