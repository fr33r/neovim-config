return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup()

    mason_lspconfig.setup({
      -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
      ensure_installed = {
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

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "eslint_d",
        "rubocop",
        "jq",
        "golines",
        "gofumpt",
        "goimports-reviser",
        -- java-debug-adapter and java-test are installed by nvim-java itself
        -- (see lua/freer/plugins/lsp/jdtls.lua). Don't dual-manage them here.
      },
    })
  end,
}
