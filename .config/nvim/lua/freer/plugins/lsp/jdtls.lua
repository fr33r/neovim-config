-- nvim-java: high-level Java (JDTLS) setup that wraps nvim-jdtls, nvim-dap,
-- spring-boot.nvim, java-test, java-debug-adapter, and Lombok. Owns
-- installation of JDTLS + bundles via Mason and starts the language server
-- on Java buffers. Replaces the previous hand-rolled ftplugin/java.lua.
return {
  "nvim-java/nvim-java",
  -- Load eagerly (no ft/event gate): nvim-java must register its jdtls
  -- config and bundles BEFORE the first Java buffer triggers auto-attach.
  -- Gating on ft=java caused a race where jdtls started without the
  -- java-debug bundle, breaking `vscode.java.resolveMainClass`.
  -- Do NOT list nvim-java-core / nvim-java-test / nvim-java-dap /
  -- lua-async-await as dependencies. nvim-java vendors those under its own
  -- lua/ tree; declaring them as separate plugins pulls in the standalone
  -- repos, which share module names ("java-core.*") and shadow the vendored
  -- copies. The standalone `java-core.ls.servers.jdtls` reads a different
  -- opts field, so init_options.bundles silently resolves to [] and
  -- vscode.java.resolveMainClass 404s at DAP config time.
  dependencies = {
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
    "JavaHello/spring-boot.nvim",
  },
  config = function()
    -- MUST run before vim.lsp.enable('jdtls') — nvim-java registers the jdtls
    -- LSP config as a side effect of setup(). Reversing the order silently
    -- boots a bare jdtls with no bundles/lombok wiring.
    require("java").setup({
      jdtls = { auto_install = true },
      lombok = { enable = true, auto_install = true },
      java_test = { enable = true, auto_install = true },
      java_debug_adapter = { enable = true, auto_install = true },
      spring_boot_tools = { enable = true, auto_install = true },
    })

    local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = ok_cmp and cmp_nvim_lsp.default_capabilities() or nil

    -- Overrides layered on top of nvim-java's defaults. Registered before
    -- vim.lsp.enable so the first buffer attach picks them up.
    vim.lsp.config("jdtls", {
      capabilities = capabilities,
      settings = {
        java = {
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.jupiter.api.Assumptions.*",
              "org.junit.jupiter.api.DynamicContainer.*",
              "org.junit.jupiter.api.DynamicTest.*",
              "org.mockito.Mockito.*",
              "java.util.Objects.requireNonNull",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },
      on_attach = function(_, bufnr)
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("<leader>Jo", function()
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            apply = true,
          })
        end, "Java: organize imports")
        map("<leader>Jv", function() require("java").refactor.extract_variable() end, "Java: extract variable")
        map("<leader>Jc", function() require("java").refactor.extract_constant() end, "Java: extract constant")
        map("<leader>Jm", function() require("java").refactor.extract_method() end, "Java: extract method")
        map("<leader>Jf", function() require("java").refactor.extract_field() end, "Java: extract field")
        map("<leader>Jt", function() require("java").test.run_current_method() end, "Java: run nearest test method")
        map("<leader>JT", function() require("java").test.run_current_class() end, "Java: run test class")
        map("<leader>Jd", function() require("java").test.debug_current_method() end, "Java: debug nearest test method")
        map("<leader>JD", function() require("java").test.debug_current_class() end, "Java: debug test class")
        map("<leader>Jr", function() require("java").runner.built_in.run_app({}) end, "Java: run main")
        map("<leader>Js", function() require("java").runner.built_in.stop_app() end, "Java: stop main")
        map("<leader>Jl", function() require("java").runner.built_in.toggle_logs() end, "Java: toggle runner logs")
        map("<leader>Jp", function() require("java").profile.ui() end, "Java: profiles UI")

        -- JDTLS source-action generators. These are exposed as
        -- CodeActionKind = "source.*" and are NOT surfaced by a bare
        -- vim.lsp.buf.code_action() call — the request must set
        -- context.only to include them explicitly.
        local source_action = function(kind, apply)
          return function()
            vim.lsp.buf.code_action({
              context = { only = { kind }, diagnostics = {} },
              apply = apply or false,
            })
          end
        end
        map("<leader>Jg",  source_action("source"),                          "Java: source actions (picker)")
        map("<leader>Jga", source_action("source.generate.accessors"),      "Java: generate getters/setters")
        map("<leader>Jgc", source_action("source.generate.constructors"),   "Java: generate constructors")
        map("<leader>Jge", source_action("source.generate.hashCodeEquals"), "Java: generate equals + hashCode")
        map("<leader>Jgs", source_action("source.generate.toString"),       "Java: generate toString")
        map("<leader>Jgo", source_action("source.overrideMethods"),         "Java: override / implement methods")
      end,
    })

    vim.lsp.enable("jdtls")
  end,
}
