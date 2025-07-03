-- Lua-specific settings and keymaps
-- This file is sourced after LSP initializes for Lua files

local bufnr = vim.api.nvim_get_current_buf()

-- Lua-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "-- %s"

-- Folding for better code organization
vim.wo.foldmethod = "expr"
vim.wo.foldexpr =
	"v:lnum==1?'>1':getline(v:lnum)=~'^\\s*--'&&getline(v:lnum+1)=~'^\\s*[^-]'?'>1':getline(v:lnum)=~'^\\s*}'?'<1':getline(v:lnum)=~'^\\s*{'?'>1':'='"

-- Lua-specific keymaps
local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Lua: " .. desc })
end

-- Execute Lua code
map("<leader>lr", function()
	-- Run current buffer as Lua
	vim.cmd("luafile %")
end, "[R]un Buffer")

map("<leader>le", function()
	-- Execute current line as Lua
	local line = vim.api.nvim_get_current_line()
	local ok, result = pcall(loadstring(line))
	if ok then
		if result ~= nil then
			vim.notify(vim.inspect(result), vim.log.levels.INFO)
		else
			vim.notify("Executed successfully", vim.log.levels.INFO)
		end
	else
		vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
	end
end, "[E]xecute Line")

-- Visual mode: execute selection
vim.keymap.set("v", "<leader>le", function()
	-- Get visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_pos[2] - 1, end_pos[2], false)

	-- Join lines and execute
	local code = table.concat(lines, "\n")
	local ok, result = pcall(loadstring(code))
	if ok then
		if result ~= nil then
			vim.notify(vim.inspect(result), vim.log.levels.INFO)
		else
			vim.notify("Executed successfully", vim.log.levels.INFO)
		end
	else
		vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
	end
end, { buffer = bufnr, desc = "Lua: Execute Selection" })

-- Module management for Neovim config development
map("<leader>lm", function()
	-- Reload current module (useful for config development)
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	local lua_path = filepath:match("lua/(.+)%.lua$")
	if lua_path then
		local module_name = lua_path:gsub("/", ".")
		package.loaded[module_name] = nil
		local ok, result = pcall(require, module_name)
		if ok then
			vim.notify("Reloaded module: " .. module_name, vim.log.levels.INFO)
		else
			vim.notify("Error reloading module: " .. tostring(result), vim.log.levels.ERROR)
		end
	else
		vim.notify("Not a Lua module in the lua/ directory", vim.log.levels.WARN)
	end
end, "Reload [M]odule")

-- Source current file (alternative to luafile)
map("<leader>ls", function()
	vim.cmd("source %")
	vim.notify("Sourced current file", vim.log.levels.INFO)
end, "[S]ource File")

-- Insert common Lua patterns
map("<leader>lp", function()
	-- Insert pcall wrapper
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local indent = string.match(vim.api.nvim_get_current_line(), "^%s*") or ""
	local pcall_lines = {
		indent .. "local ok, result = pcall(function()",
		indent .. "  ",
		indent .. "end)",
		indent .. "if not ok then",
		indent .. "  vim.notify('Error: ' .. result, vim.log.levels.ERROR)",
		indent .. "  return",
		indent .. "end",
	}
	vim.api.nvim_buf_set_lines(bufnr, line, line, false, pcall_lines)
	vim.api.nvim_win_set_cursor(0, { line + 2, #indent + 2 })
end, "Insert [P]call Pattern")

-- Quick inspect helper
map("<leader>li", function()
	-- Insert vim.inspect() around current word
	local word = vim.fn.expand("<cword>")
	local inspect_call = string.format("vim.notify(vim.inspect(%s), vim.log.levels.INFO)", word)
	vim.cmd("normal! ciw" .. inspect_call)
end, "[I]nspect Variable")

-- Table/function navigation helpers
map("<leader>lf", function()
	-- Jump to next function definition
	vim.fn.search("^\\s*\\(local\\s\\+\\)\\?function\\|^\\s*\\w\\+\\s*=\\s*function", "W")
end, "Next [F]unction")

map("<leader>lF", function()
	-- Jump to previous function definition
	vim.fn.search("^\\s*\\(local\\s\\+\\)\\?function\\|^\\s*\\w\\+\\s*=\\s*function", "bW")
end, "Previous [F]unction")

-- Neovim config specific helpers
if vim.fn.expand("%:p"):match(vim.fn.stdpath("config")) then
	map("<leader>lc", function()
		-- Quick config reload (only in config directory)
		vim.cmd("source $MYVIMRC")
		vim.notify("Reloaded Neovim config", vim.log.levels.INFO)
	end, "Reload [C]onfig")

	map("<leader>ll", function()
		-- Open lazy plugin manager
		vim.cmd("Lazy")
	end, "Open [L]azy")
end
