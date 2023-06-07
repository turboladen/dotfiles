local function GetSetup(name)
	function do_it()
		local path = string.format("setup/%s", name)
		require(path)
	end

	-- require(string.format("setup/%s", name))
end

local enable_treesitter = true

return {
	-- ╔════════════════════════════════════════════════════════════════════╗
	-- ║ 0.                                                                 ║
	-- ╚════════════════════════════════════════════════════════════════════╝

	-- ╭──────────────────────────────────────────────────╮
	-- │  Enable repeating supported plugin maps with '.' │
	-- ╰──────────────────────────────────────────────────╯
	{ "tpope/vim-repeat" },

	-- ╭───────────────────────────────────────────────────────────────────────────╮
	-- │ Open the current word with custom openers, GitHub shorthands for example. │
	-- ╰───────────────────────────────────────────────────────────────────────────╯
	-- {
	--   'ofirgall/open.nvim',
	--   dependencies = { 'nvim-lua/plenary.nvim' },
	--   config = {},
	--   init = function()
	--     require("setup/open-nvim").set_keymaps()
	--   end
	-- },

	-- -- Opener of open.nvim that opens shorthands of Jira tickets, E.g: JRASERVER-63928.
	-- {
	--   'ofirgall/openjira.nvim',
	--   dependencies = { 'ofirgall/open' },
	--   config = require("setup/open-jira-nvim").config
	-- },

	-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
	-- ┃ UI tweaks                                                ┃
	-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
	-- ╭────────────────────────────────────────╮
	-- │ Enhanced terminal integration for Vim. │
	-- ╰────────────────────────────────────────╯
	{ "wincent/terminus" },

	-- ╭────────────────────────────────────────────────╮
	-- │ Plugin for calling lazygit from within neovim. │
	-- ╰────────────────────────────────────────────────╯
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "LazyGit" }
	},


	-- ╭────────────────────────────────────────────────────────╮
	-- │ Neovim plugin to improve the default vim.ui interfaces │
	-- ╰────────────────────────────────────────────────────────╯
	{ 'stevearc/dressing.nvim',          event = "VeryLazy" },

	-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
	-- ┃ 2. moving around, searching and patterns                                               ┃
	-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
	-- ╭─────────────────────────────────╮
	-- │ pairs of handy bracket mappings │
	-- ╰─────────────────────────────────╯
	{ "tpope/vim-unimpaired" },

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │ Vim plugin, provides insert mode auto-completion for quotes,             │
	-- │ parens, brackets, etc.                                                   │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{ "Raimondi/delimitMate" },

	-- ╭──────────────────────────────────────────────────────────╮
	-- │    A file manager for Neovim which lets you edit your    │
	-- │              filesystem like you edit text               │
	-- ╰──────────────────────────────────────────────────────────╯
	{ "elihunter173/dirbuf.nvim" },

	-- ╭──────────────────────────────────────────╮
	-- │ Change code right in the quickfix window │
	-- ╰──────────────────────────────────────────╯
	{ "stefandtw/quickfix-reflector.vim" },

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │ -- Space Age seD in Neovim. A project-wide find and replace plugin       │
	-- │ for Neovim.                                                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	-- use({
	--   "ray-x/sad.nvim",
	--   dependencies = { "ray-x/guihua.lua" },
	--   config = function()
	--     require("sad").setup({})
	--   end
	-- })

	-- ╔════════════════════════════════════════════════════════════════════════════════════════╗
	-- ║ 5. syntax, highlighting and spelling                                                   ║
	-- ╚════════════════════════════════════════════════════════════════════════════════════════╝
	-- ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ colorschemes                                             ╎
	-- └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │ NeoVim dark colorscheme inspired by the colors of the famous             │
	-- │ painting by Katsushika Hokusai.                                          │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},

	-- ╭──────────────────────────────────────────────────────╮
	-- │ A very dark colorscheme for Vim. JOIN THE DARK SIDE! │
	-- ╰──────────────────────────────────────────────────────╯
	{
		"aonemd/kuroi.vim",
		lazy = true
	},

	-- ╔══════════════════════════════════════════════════════════════════════════════╗
	-- ║ 6. multiple windows                                                          ║
	-- ╚══════════════════════════════════════════════════════════════════════════════╝
	-- ╭────────────────────────────────────────────────────────╮
	-- │ Delete all the buffers except the current/named buffer │
	-- ╰────────────────────────────────────────────────────────╯
	{ "vim-scripts/BufOnly.vim",  cmd = "BufOnly" },

	-- ╔══════════════════════════════════════════════════════════════════════════════╗
	-- ║ 13. editing text                                                             ║
	-- ╚══════════════════════════════════════════════════════════════════════════════╝
	-- ╭─────────────────────────────────────────────────────╮
	-- │ Auto close parentheses and repeat by dot dot dot... │
	-- ╰─────────────────────────────────────────────────────╯
	{ "cohama/lexima.vim" },

	-- ╭────────────╮
	-- │ Wisely add │
	-- ╰────────────╯
	{ "tpope/vim-endwise" },

	-- ╭────────────────────────────────╮
	-- │ A better annotation generator. │
	-- ╰────────────────────────────────╯
	-- {
	--   "danymat/neogen",
	--   dependencies = {  "nvim-treesitter/nvim-treesitter" },
	--   config = GetSetup("neogen"),
	-- },

	-- ╭────────────────────────────────────╮
	-- │ quoting/parenthesizing made simple │
	-- ╰────────────────────────────────────╯
	{ "tpope/vim-surround" },

	-- ╭───────────────────────────────────────────╮
	-- │ Adds gS and gJ to split/join code blocks. │
	-- ╰───────────────────────────────────────────╯
	{ "AndrewRadev/splitjoin.vim" },

	-- ╭─────────────────────────────╮
	-- │ Easy text exchange operator │
	-- ╰─────────────────────────────╯
	{ "tommcdo/vim-exchange" },


	-- ╭───────────────────╮
	-- │ For case swapping │
	-- ╰───────────────────╯
	{ "idanarye/vim-casetrate",   cmd = "Casetrate" },

	-- ╭─────────────────────────────────────────────╮
	-- │ Vim script for text filtering and alignment │
	-- ╰─────────────────────────────────────────────╯
	{ "godlygeek/tabular",        cmd = "Tabularize" },

	-- ╭──────────────────────────────────────────────────────────────╮
	-- │ ✨ Clarify and beautify your comments using boxes and lines. │
	-- ╰──────────────────────────────────────────────────────────────╯
	{
		"LudoPinelli/comment-box.nvim",
		cmd = {
			"CBlbox", -- Left aligned box of fixed size with Left aligned text
			"CBclbox", -- Centered box of fixed size with Left aligned text
			"CBcbox", -- Left aligned box of fixed size with centered text
			"CBccbox", -- Centered box of fixed size with centered text
			"CBalbox", -- Left aligned adapted box with Left aligned text
			"CBaclbox", -- Centered adapted box with Left aligned text
			"CBacbox", -- Left aligned adapted box with centered text
			"CBaccbox", -- Centered adapted box with centered text
		}
	},

	-- ╔══════════════════════════════════════════════════════════════════════════════╗
	-- ║ 21. executing external commands                                              ║
	-- ╚══════════════════════════════════════════════════════════════════════════════╝
	-- ╭─────────────────────────────────────────────────────────────╮
	-- │ Vim sugar for the UNIX shell commands that need it the most │
	-- ╰─────────────────────────────────────────────────────────────╯
	{
		"tpope/vim-eunuch",
		cmd = {
			"Chmod",
			"Delete",
			"Mkdir",
			"Move",
			"Remove",
			"Rename",
			"Unlink",
		},
	},

	-- ╔══════════════════════════════════════════════════════════════════════════════╗
	-- ║ 22. running make and jumping to errors (quickfix)                            ║
	-- ╚══════════════════════════════════════════════════════════════════════════════╝
	-- ╭───────────────────────────────────────────────────────────────────╮
	-- │ An extensible framework for interacting with tests within NeoVim. │
	-- ╰───────────────────────────────────────────────────────────────────╯
	-- use({
	--   "nvim-neotest/neotest",
	--   dependencies = {
	--     "antoinemadec/FixCursorHold.nvim",
	--     "nvim-lua/plenary.nvim",
	--     "nvim-treesitter/nvim-treesitter",
	--     "olimorris/neotest-rspec",
	--     "rouge8/neotest-rust"
	--   },
	--   config = GetSetup("neotest")
	-- })

	-- ╔══════════════════════════════════════════════════════════════════════════════╗
	-- ║ 23. language specific                                                        ║
	-- ╚══════════════════════════════════════════════════════════════════════════════╝

	-- ╭────────────────────────────────────────────────────╮
	-- │ Vim syntax file & snippets for Docker's Dockerfile │
	-- ╰────────────────────────────────────────────────────╯
	{ "ekalinin/Dockerfile.vim" },

	-- ┌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎  Git     ╎
	-- └╌╌╌╌╌╌╌╌╌╌┘
	-- ┌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ HTML     ╎
	-- └╌╌╌╌╌╌╌╌╌╌┘
	-- ╭───────────────╮
	-- │ emmet for vim │
	-- ╰───────────────╯
	{ "mattn/emmet-vim",        ft = { "html" } },

	-- ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ markdown     ╎
	-- └╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
	-- ╭───────────────────╮
	-- │ Markdown Vim Mode │
	-- ╰───────────────────╯
	-- use({
	--   "preservim/vim-markdown",
	--   config = GetSetup("vim-markdown"),
	-- })

	-- ┌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ Ruby     ╎
	-- └╌╌╌╌╌╌╌╌╌╌┘
	-- ╭───────────────────────────╮
	-- │ Ruby on Rails power tools │
	-- ╰───────────────────────────╯
	{
		"tpope/vim-rails",
		ft = { "ruby", "eruby", "rspec" },
	},

	-- ╭───────────────────────────────────────╮
	-- │ It's like rails.vim without the rails │
	-- ╰───────────────────────────────────────╯
	{
		"tpope/vim-rake",
		ft = { "ruby", "eruby", "rspec" },
		dependencies = { "tpope/vim-projectionist" },
	},

	-- ╭─────╮
	-- │ RBS │
	-- ╰─────╯
	-- use '~/Development/projects/vim-rbs'
	{
		"turboladen/vim-rbs",
		ft = { "ruby", "rbs", "ruby.rbs", "rspec" }
	},

	-- ┌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ tmux     ╎
	-- └╌╌╌╌╌╌╌╌╌╌┘
	-- ╭───────────────────────────────────────────────────────────────────────────╮
	-- │ Restores `FocusGained` and `FocusLost` autocommand events work when using │
	-- │ vim inside Tmux.                                                          │
	-- ╰───────────────────────────────────────────────────────────────────────────╯
	{ "tmux-plugins/vim-tmux-focus-events" },

	-- ┌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ wren     ╎
	-- └╌╌╌╌╌╌╌╌╌╌┘
	-- use({ "kettek/vim-wren-syntax", ft = "wren" })

	-- ┌╌╌╌╌╌╌╌╌╌╌┐
	-- ╎ YAML     ╎
	-- └╌╌╌╌╌╌╌╌╌╌┘
	-- ╭────────────────────────────────────────────╮
	-- │ Override vim syntax for yaml files.        │
	-- │                                            │
	-- │ Also, this isn't provided in vim-polyglot. │
	-- ╰────────────────────────────────────────────╯
	{ "stephpy/vim-yaml",                  ft = "yaml" },

	-- ╔══════════════════════════════════════════════════════════════════════════════╗
	-- ║ 25. various                                                                  ║
	-- ╚══════════════════════════════════════════════════════════════════════════════╝
	-- ╭─────────────────────────────────────────────────────────╮
	-- │ Debug Adapter Protocol client implementation for Neovim │
	-- ╰─────────────────────────────────────────────────────────╯
	-- use({
	--   "mfussenegger/nvim-dap",
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   config = GetSetup("nvim-dap"),
	-- })

	-- ╭───────────────────╮
	-- │ A UI for nvim-dap │
	-- ╰───────────────────╯
	-- use({
	--   "rcarriga/nvim-dap-ui",
	--   dependencies = { "mfussenegger/nvim-dap" },
	--   config = GetSetup("nvim-dap-ui"),
	-- })

	-- ╭────────────────────────────────────────────────────╮
	-- │ This plugin adds virtual text support to nvim-dap. │
	-- ╰────────────────────────────────────────────────────╯
	-- use({
	--   "theHamsta/nvim-dap-virtual-text",
	--   dependencies = {
	--     "nvim-treesitter/nvim-treesitter",
	--     "mfussenegger/nvim-dap",
	--   },
	--   enabled = enable_treesitter,
	--   config = GetSetup("nvim-dap-virtual-text"),
	-- })

	-- ╭───────────────────────────────────────────────────────────────────────────╮
	-- │ 🌈 Plugin that creates missing LSP diagnostics highlight groups for color │
	-- │ schemes that don't yet support the Neovim 0.5 builtin LSP client.         │
	-- ╰───────────────────────────────────────────────────────────────────────────╯
	{ "folke/lsp-colors.nvim",             opts = {} },
}
