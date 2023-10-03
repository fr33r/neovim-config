local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gf", "<CMD>Lspsaga lsp_finder<CR>", opts)
	keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap.set("n", "gd", "<CMD>Lspsaga peek_definition<CR>", opts)
	keymap.set("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap.set("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", opts)
	keymap.set("n", "<leader>rn", "<CMD>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>d", "<CMD>Lspsaga show_line_diagnostics<CR>", opts)
	keymap.set("n", "<leader>d", "<CMD>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap.set("n", "<leader>kd", "<CMD>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "<leader>jd", "<CMD>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "K", "<CMD>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>o", "<CMD>LSoutlineToggle<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["solargraph"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
