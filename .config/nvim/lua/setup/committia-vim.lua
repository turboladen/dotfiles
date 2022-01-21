
                    vim.g.committia_hooks = {}
                    vim.g.committia_hooks.edit_open = function(info)
                        vim.opt_local.spell = true
                        -- If no commit message, start with insert mode
                        if info.vcs == "git" and vim.fn.getline(1) == "" then
                            vim.fn.startinsert()
                        end
                    end
