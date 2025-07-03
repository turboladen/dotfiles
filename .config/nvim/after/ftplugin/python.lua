-- Python-specific settings and keymaps
-- This file is sourced after LSP initializes for Python files

local bufnr = vim.api.nvim_get_current_buf()

-- Python-specific buffer settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"
vim.bo.textwidth = 88 -- Black formatter default

-- Python-specific window settings
vim.wo.colorcolumn = "88,120"

-- Python-specific keymaps
local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Python: " .. desc })
end

-- Import helpers
map("<leader>pi", function()
	-- Insert import statement
	vim.api.nvim_put({ "import " }, "c", false, true)
	vim.cmd("startinsert!")
end, "[I]mport statement")

map("<leader>pf", function()
	-- Insert from import statement
	vim.api.nvim_put({ "from  import " }, "c", false, true)
	vim.api.nvim_feedkeys("F i", "n", false)
end, "[F]rom import statement")

-- Function/class creation helpers
map("<leader>pd", function()
	-- Insert function definition
	local lines = {
		"def ():",
		"    pass",
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
	vim.api.nvim_win_set_cursor(0, { row + 1, 4 })
end, "[D]ef function")

map("<leader>pc", function()
	-- Insert class definition
	local lines = {
		"class ():",
		"    pass",
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
	vim.api.nvim_win_set_cursor(0, { row + 1, 6 })
end, "[C]lass definition")

map("<leader>pm", function()
	-- Insert main guard
	local lines = {
		"",
		'if __name__ == "__main__":',
		"    ",
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
	vim.api.nvim_win_set_cursor(0, { row + 3, 4 })
end, "[M]ain guard")

-- Debugging helpers
map("<leader>pp", function()
	-- Insert print statement for debugging
	local word = vim.fn.expand("<cword>")
	local print_stmt = string.format('print(f"{%s = }")', word)
	vim.api.nvim_put({ print_stmt }, "l", true, true)
end, "[P]rint debug")

map("<leader>pb", function()
	-- Insert breakpoint
	vim.api.nvim_put({ "breakpoint()" }, "l", true, true)
end, "[B]reakpoint")

-- Docstring helpers
map("<leader>pds", function()
	-- Insert docstring template
	local lines = {
		'"""',
		"",
		'"""',
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
	vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
end, "[D]oc[s]tring")

-- Type hints helpers
map("<leader>pt", function()
	-- Insert type hint arrow
	vim.api.nvim_put({ " -> " }, "c", false, true)
	vim.cmd("startinsert!")
end, "[T]ype hint arrow")

-- Virtual environment helpers
map("<leader>pv", function()
	-- Show current Python interpreter
	local python_path = vim.fn.exepath("python")
	vim.notify("Python interpreter: " .. python_path, vim.log.levels.INFO)
end, "Show [V]irtual env")

-- Common Python patterns
map("<leader>pe", function()
	-- Insert try/except block
	local lines = {
		"try:",
		"    ",
		"except Exception as e:",
		"    raise",
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
	vim.api.nvim_win_set_cursor(0, { row + 2, 4 })
end, "Try/[E]xcept block")

map("<leader>pw", function()
	-- Insert with statement
	vim.api.nvim_put({ "with  as :" }, "c", false, true)
	vim.api.nvim_feedkeys("F i", "n", false)
end, "[W]ith statement")

-- Test helpers
map("<leader>pu", function()
	-- Insert unittest method
	local lines = {
		"def test_():",
		"    pass",
	}
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
	vim.api.nvim_win_set_cursor(0, { row + 1, 9 })
end, "[U]nittest method")

-- Run Python file (if python is available)
if vim.fn.executable("python") == 1 then
	map("<leader>pr", function()
		-- Run current Python file
		local file_path = vim.api.nvim_buf_get_name(bufnr)
		if file_path ~= "" then
			vim.cmd("split | terminal python " .. vim.fn.shellescape(file_path))
		else
			vim.notify("Save the file first", vim.log.levels.WARN)
		end
	end, "[R]un Python file")
end

-- Set up Python-specific abbreviations for common patterns
vim.cmd([[iabbrev <buffer> pprint import pprint; pprint.pprint()]])
vim.cmd([[iabbrev <buffer> ipdb import ipdb; ipdb.set_trace()]])
vim.cmd([[iabbrev <buffer> pudb import pudb; pudb.set_trace()]])
