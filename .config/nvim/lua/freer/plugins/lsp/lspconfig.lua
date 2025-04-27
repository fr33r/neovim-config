return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { silent = true, buffer = ev.buf }
				--
				-- opts.desc = "Show LSP references"
				-- keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)
				-- opts.desc = "Go to declaration"
				-- keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration<CR>", opts)
				-- opts.desc = "Go to definition"
				-- keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
				-- keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)
				-- keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts)
				-- keymap.set("n", "<leader>ca", "<CMD>vim.lsp.buf.code_action<CR>", opts)
				-- keymap.set("n", "<leader>rn", "<CMD>vim.lsp.buf.rename<CR>", opts)
				-- keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics bufnr=0<CR>", opts)
				-- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				-- keymap.set("n", "<leader>kd", vim.diagnostic.goto_prev, opts)
				-- keymap.set("n", "<leader>jd", vim.diagnostic.goto_next, opts)
				-- keymap.set("n", "K", vim.lsp.buf.hover, opts)
				-- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				-- opts.desc = "See available code actions"
				-- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				-- opts.desc = "Show buffer diagnostics"
				-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
				--
				-- opts.desc = "Show line diagnostics"
				-- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
				--
				-- opts.desc = "Go to previous diagnostic"
				-- keymap.set("n", "kd", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
				--
				-- opts.desc = "Go to next diagnostic"
				-- keymap.set("n", "jd", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({ capabilities = capabilities })
			end,
		})
	end,
}
