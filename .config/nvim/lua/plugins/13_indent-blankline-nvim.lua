-- ╭──────────────────────────────────────────╮
-- │ Show vertical line for indentation level │
-- ╰──────────────────────────────────────────╯
return {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
        char = "┊",
        char_highlight = "LineNr",
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = { "rust", "lua", "ruby" },
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    },
    config = function(_, opts)
        require("indent_blankline").setup(opts)
    end,
    init = function()
        vim.opt.list = true
    end
}
