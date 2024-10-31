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
    local mason_lspconfig= require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { silent = true, buffer = ev.buf }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)
        opts.desc = "Go to declaration"
        keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration<CR>", opts)
        opts.desc = "Go to definition"
        keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
        keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)
        keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts)
        keymap.set("n", "<leader>ca", "<CMD>vim.lsp.buf.code_action<CR>", opts)
        keymap.set("n", "<leader>rn", "<CMD>vim.lsp.buf.rename<CR>", opts)
        keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics bufnr=0<CR>", opts)
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        keymap.set("n", "<leader>kd", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "<leader>jd", vim.diagnostic.goto_next, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })


    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({ capabilities = capabilities })
      end
    })
  end,
}
