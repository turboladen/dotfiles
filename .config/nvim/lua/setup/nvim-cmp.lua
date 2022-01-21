local cmp = require("cmp")

cmp.setup(
    {
        completion = {
            keyword_length = 2
        },
        experimental = {},
        formatting = {
            format = require("lspkind").cmp_format()
        },
        mapping = {
            -- ["<C-j>"] = cmp.mapping.select_next_item(),
            -- ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
            ["<C-k>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
            ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
            ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
            ["<CR>"] = cmp.mapping(
                {
                    i = cmp.mapping.confirm({select = true}),
                    c = cmp.mapping.confirm({select = true})
                }
            )
                -- ["<C-CR>"] = cmp.mapping(
                    --     {
                        --         i = cmp.mapping.confirm({select = true, benavior = cmp.SelectBehavior.Replace}),
                        --         c = cmp.mapping.confirm({select = true, benavior = cmp.SelectBehavior.Replace})
                            --     }
                            -- )
        },
        snippet = {
            expand = function(args)
                require("snippy").expand_snippet(args.body) -- For `snippy` users.
                end
        },
        sources = {
            {name = "nvim_lsp", priority = 6},
            {name = "snippy", priority = 2},
            -- {name = "buffer", max_item_count = 5},
            {name = "path", max_item_count = 5},
            {name = "nvim_lua"}
        }
    }
)

local snippy = require("snippy")
snippy.setup(
    {
        mappings = {
            is = {
                ["<Tab>"] = "expand_or_advance",
                ["<S-Tab>"] = "previous"
            },
            nx = {
                ["<leader>x"] = "cut_text"
            }
        }
    }
)

