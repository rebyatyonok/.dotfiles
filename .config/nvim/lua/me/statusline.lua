local StatusLine = {}

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

function StatusLine.get()
	print("Hello from statusline.lua")
	local file_name = vim.fn.expand("%:t")
	local file_type = vim.bo.filetype
	local line_number = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local column_number = vim.fn.col(".")

	return string.format(
		mode(),
		file_name,
		file_type,
		line_number,
		total_lines,
		column_number
	)
end

return StatusLine
