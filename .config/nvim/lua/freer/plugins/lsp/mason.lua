local mason_setup, mason = pcall(require, 'mason')
if not mason_setup then
  return
end

local mason_lspconfig_setup, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_setup then
  return
end

mason.setup()

mason_lspconfig.setup({
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {
    'tsserver',
    'html',
    'tailwindcss',
    'bashls',
    'cssls',
    'dockerls',
    'dotls',
    'gopls',
    'jsonls',
    'marksman',
    'spectral',
    'solargraph',
    'sqlls',
    'yamlls',
  }
})
