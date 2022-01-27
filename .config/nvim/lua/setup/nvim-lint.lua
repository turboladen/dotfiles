-- require("turboladen.installers").gem_install("brakeman")
-- require("turboladen.installers").gem_install("debride")
-- require("turboladen.installers").gem_install("reek")
-- require("turboladen.installers").gem_install("sorbet")
-- require("turboladen.installers").pip_install("vim-vint")
-- require("turboladen.installers").pip_install("yamllint")

local lint = require("lint")

-- lint.linters.brakeman = {
--     cmd = "brakeman",
--     args = {
--         "-q",
--         "--faster",
--         "--no-color",
--         "--no-highlights",
--         "--no-pager"
--     },
--     stream = "stdout",
--     parser = function()
--         -- Need to figure this out before it'll work.
--     end
-- }
-- lint.linters.debride = {
--     cmd = "debride",
--     args = {"."},
--     stream = "stdout",
--     parser = function()
--         -- Need to figure this out before it'll work.
--     end
-- }
-- lint.linters.reek = {
--     cmd = "reek",
--     args = {
--         "--format",
--         "json",
--         "--no-color",
--         "--line-numbers",
--         "--no-progress"
--     },
--     stream = "stdout",
--     parser = function()
--         -- Need to figure this out before it'll work.
--     end
-- }

lint.linters_by_ft = {
    markdown = {"vale", "markdownlint"},
    -- ruby = {"brakeman", "debride", "reek", "ruby", "sorbet"},
    ruby = {"ruby"},
    vim = {"vint"},
    sh = {"shellcheck"},
    yaml = {"yamllint"},
    zsh = {"shellcheck"}
}

vim.cmd([[
  autocmd BufWritePost ruby,vim,zsh,vimscript,bash,sh,markdown,yaml <buffer> require('lint').try_lint()
]])
