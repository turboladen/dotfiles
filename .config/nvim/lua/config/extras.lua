-- Configuration for loading extras
-- Auto-discovers extras with manual override capability

local M = {}

-- Manual overrides - set to false to disable specific extras
-- If not specified here, extras are enabled by default
M.overrides = {
	-- Disable specific extras by uncommenting:
	-- ["lang.python"] = false,
	-- ["ai"] = false,
	-- ["dap"] = false,
}

-- Get all available extras by scanning the filesystem
local function get_available_extras()
	local extras = {}
	local extras_path = vim.fn.stdpath("config") .. "/lua/plugins/extras"

	-- Helper function to scan directory recursively
	local function scan_dir(path, prefix)
		local handle = vim.uv.fs_scandir(path)
		if not handle then
			return
		end

		while true do
			local name, type = vim.uv.fs_scandir_next(handle)
			if not name then
				break
			end

			local full_path = path .. "/" .. name
			local extra_name = prefix and (prefix .. "." .. name) or name

			if type == "directory" then
				-- Recursively scan subdirectories
				scan_dir(full_path, extra_name)
			elseif type == "file" and name:match("%.lua$") then
				-- Remove .lua extension and add to extras list
				local clean_name = extra_name:gsub("%.lua$", "")
				table.insert(extras, clean_name)
			end
		end
	end

	-- Scan the extras directory
	scan_dir(extras_path)

	return extras
end

-- Get list of enabled extras
function M.get_enabled_extras()
	local available = get_available_extras()
	local enabled = {}

	for _, name in ipairs(available) do
		-- Check if this extra is explicitly disabled
		local is_enabled = M.overrides[name] ~= false

		if is_enabled then
			table.insert(enabled, { import = "plugins.extras." .. name })
		end
	end

	-- Sort for consistent loading order
	table.sort(enabled, function(a, b)
		return a.import < b.import
	end)

	return enabled
end

-- Debug function to see what extras are available/enabled
function M.list_extras()
	local available = get_available_extras()
	local enabled_map = {}

	for _, spec in ipairs(M.get_enabled_extras()) do
		local name = spec.import:gsub("^plugins%.extras%.", "")
		enabled_map[name] = true
	end

	vim.notify("Available extras:", vim.log.levels.INFO)
	for _, name in ipairs(available) do
		local status = enabled_map[name] and "✓" or "✗"
		vim.notify(string.format("  %s %s", status, name), vim.log.levels.INFO)
	end
end

return M
