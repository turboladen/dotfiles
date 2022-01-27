vim.g.floaterm_wintype = "split"
vim.g.floaterm_autoclose = 1
vim.g.floaterm_autoinsert = false
vim.g.floaterm_height = 0.3

vim.g["test#strategy"] = {
    nearest = "floaterm",
    last = "floaterm",
    file = "dispatch",
    suite = "dispatch"
}
vim.g["test#preserve_screen"] = 1
vim.g["test#enabled_runners"] = {
    "ruby#rspec",
    "ruby#rails",
    "rust#cargotest"
}
