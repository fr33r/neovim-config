return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("nvim-dap-virtual-text").setup()

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      -- Breakpoints and inspection
      map("<leader>db", dap.toggle_breakpoint, "DAP: toggle breakpoint")
      map("<leader>dB", function()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
          if cond and cond ~= "" then dap.set_breakpoint(cond) end
        end)
      end, "DAP: conditional breakpoint")
      map("<leader>dg", dap.run_to_cursor, "DAP: run to cursor")
      map("<leader>de", function() ui.eval(nil, { enter = true }) end, "DAP: eval under cursor")
      map("<leader>du", ui.toggle, "DAP: toggle UI")

      -- Session control
      map("<leader>dc", dap.continue, "DAP: continue / start")
      map("<leader>di", dap.step_into, "DAP: step into")
      map("<leader>do", dap.step_over, "DAP: step over")
      map("<leader>dO", dap.step_out, "DAP: step out")
      map("<leader>dr", dap.restart, "DAP: restart")
      map("<leader>dq", dap.terminate, "DAP: terminate")

      -- Legacy alias — kept for muscle memory / when Fn keys reach the terminal
      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
      vim.keymap.set("n", "<space>?", function() ui.eval(nil, { enter = true }) end)
      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
