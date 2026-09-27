return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		local langs = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"go",
			"java",
		}

		ts.install(langs)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = langs,
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
