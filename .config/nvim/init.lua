require("config.lazy")

vim.o.statusline = require("me.statusline").get()

vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.swapfile = false

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true
vim.o.scrolloff = 8

vim.o.signcolumn = "number"

require("lazy").setup("plugins")
require("mini.starter").setup()
require('mini.snippets').setup()
require('mini.completion').setup()

local ai = require('mini.ai')
ai.setup({
	n_lines = 500,
	custom_textobjects = {
		o = ai.gen_spec.treesitter({ -- code block
			a = { "@block.outer", "@conditional.outer", "@loop.outer" },
			i = { "@block.inner", "@conditional.inner", "@loop.inner" },
		}),
		f = ai.gen_spec.treesitter({ -- function
			a = "@function.outer",
			i = "@function.inner"
		}),
		c = ai.gen_spec.treesitter({ -- class
			a = "@class.outer",
			i = "@class.inner"
		}),
		t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
		d = { "%f[%d]%d+" },                                              -- digits
		e = {                                                             -- Word with case
			{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
			"^().*()$",
		},
		U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
		u = ai.gen_spec.function_call(),                         -- u for "Usage"
	},
})

require("telescope").setup({
	defaults = {
		layout_strategy = "flex",
		path_display = { "smart" },
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
			enable_sorting = true,
			sort_lastused = true,
			sort_mru = true,
			sort_by_name = true,
		},
		find_files = {
			hidden = true,
			no_ignore = true,
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			file_ignore_patterns = { "^node_modules/" }
		},
	},
	extensions = {
		file_browser = {
			hidden = true,
			respect_gitignore = true,
			no_ignore = true,
			grouped = true,
			hide_parent_dir = true,
			-- hijack_netrw = true,
		},
		projects = {
			hidden_files = true,
			order_by = "asc",
		},
	}
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 100,
		lsp_format = "fallback",
	},
})

require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"c",
		"lua",
		"javascript",
		"typescript",
		"vue",
		"css",
		"markdown",
		"markdown_inline"
	},

	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

local wk = require("which-key")
local builtin = require('telescope.builtin')

-- insert mode out
vim.keymap.set({ "i", "v" }, "<C-j>", "<Esc>")

-- move blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- cursor stays in place on line join
vim.keymap.set("n", "J", "mzJ`z")

-- cursor stays in the center while scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "grh", "<cmd>lua vim.lsp.buf.hover()<cr>")

vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

wk.add({
	{ "<leader>q",  ":quit<CR>",                                                                desc = "quit" },
	{ "<leader>w",  ":write<CR>",                                                               desc = "quit" },

	{ "<leader>f",  group = "file" },
	{ "<leader>fs", ":write<CR>",                                                               desc = "save" },
	{ "<leader>fe", function() require("telescope").extensions.file_browser.file_browser() end, desc = "explorer" },
	{ "<leader>ff", builtin.find_files,                                                         desc = "find files" },

	{ "<leader>b",  group = "buffers" },
	{ "<leader>bb", builtin.buffers,                                                            desc = "buffers" },

	{ "<leader>s",  group = "search" },
	{ "<leader>sg", builtin.live_grep,                                                          desc = 'live grep' },

	{ "<leader>w",  group = "window" },
	{ "<leader>wq", "<cmd>silent! xa<cr><cmd>qa<cr>",                                           desc = "close" },
	-- paste without loosing last yank
	{ "<leader>p",  "\"_dP",                                                                    hidden = true },

	{ "<leader>p",  group = "projects" },
	{ "<leader>pp", function() require 'telescope'.extensions.project.project {} end,           desc = "projects" },


	{ "<leader>c",  group = "code" },
	{ '<leader>cu', '<cmd>lua vim.lsp.buf.references()<cr>',                                    desc = "usage" },
	{ '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<cr>',                                desc = "implementation" },
	{ '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>',                                        desc = "rename" },
	{ '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',                                   desc = "code action" },
	{ '<leader>cs', '<cmd>lua vim.lsp.buf.document_symbol()<cr>',                               desc = "document symbol" },

	{ '<C-Space>',  '<cmd>lua vim.lsp.buf.signature_help()<cr>',                                desc = "signature help",  hidden = true },

	{ "<leader>i",  group = "ai" },
	{ "<leader>ii", "<cmd>CopilotChat<cr>",                                                     desc = "copilot chat" },
	{ "<leader>iI", "<cmd>CopilotChatReset<cr><cmd>CopilotChat<cr>",                            desc = "new copilot chat" },
	{ "<leader>ic", "<cmd>Copilot<cr>",                                                         desc = "copilot code" },

	{ "<leader>d",  group = "diagnostic" },
	{ "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>",                                      desc = "toggle" },

	{
		mode = { "n", "v" },
		-- yank to system clipboard
		{ "<leader>y", "\"+y", desc = "copy to clipboard", hidden = true },
	}
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('vue_language_server')
vim.lsp.enable('css-lsp')

local vue_ls_path = vim.fn.stdpath("data")
		.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_ls_path,
	languages = { 'vue' },
	configNamespace = 'typescript',
}
local vtsls_config = {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = tsserver_filetypes,
}

local ts_ls_config = {
	init_options = {
		plugins = {
			vue_plugin,
		},
	},
	filetypes = tsserver_filetypes,
}

-- If you are not on most recent `nvim-lspconfig` or you want to override
local vue_ls_config = {
	on_init = function(client)
		client.handlers['tsserver/request'] = function(_, result, context)
			local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
			local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
			local clients = {}

			vim.list_extend(clients, ts_clients, {
				command = 'typescript.tsserverRequest',
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response = r and r.body
				-- TODO: handle error or response nil here, e.g. logging
				-- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
				local response_data = { { id, response } }

				---@diagnostic disable-next-line: param-type-mismatch
				client:notify('tsserver/response', response_data)
			end)
		end
	end,
}
-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.enable({ 'vtsls', 'vue_ls' }) -- If using `ts_ls` replace `vtsls` to `ts_ls`
