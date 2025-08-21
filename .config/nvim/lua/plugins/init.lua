return {
	{
		'projekt0n/github-nvim-theme',
		name = 'github-theme',
		lazy = false,  -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('github-theme').setup()
			vim.cmd('colorscheme github_dark_default')
		end,
	},

	{
		"neovim/nvim-lspconfig"
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'master',
		lazy = false,
		build = ":TSUpdate"
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},


	{ 'echasnovski/mini.nvim', version = '*' },

	{
		"nvim-tree/nvim-web-devicons",
		opts = {}
	},

	{
		"mason-org/mason.nvim",
		opts = {}
	},

	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	{
		'nvim-telescope/telescope-project.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
		},
	},

	{
		"github/copilot.vim"
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = 'gpt-4.1',    -- AI model to use
			temperature = 0.1,    -- Lower = focused, higher = creative
			window = {
				layout = 'vertical', -- 'vertical', 'horizontal', 'float'
				width = 0.5,        -- 50% of screen width
			},
			auto_insert_mode = true, -- Enter insert mode when opening
		}
	},

	{
		'stevearc/conform.nvim',
		opts = {},
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble"
	}
}
