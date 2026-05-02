--------------------------------------------------------------------
--- DAP: Debug Adapter Protocol for Python
--------------------------------------------------------------------
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")
      -- Determine Python path
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        local venv_python = cwd .. "/.venv/bin/python"
        if vim.fn.filereadable(venv_python) == 1 then
          return venv_python
        else
          -- fallback to debugpy from Mason
          return vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
        end
      end
      require("dapui").setup({})
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })
      dap_python.setup(get_python_path())
      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or ":x:"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })
      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      local opts = { noremap = true, silent = true }
      -- Toggle breakpoint
      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, opts)
      -- Continue / Start
      vim.keymap.set("n", "<leader>dc", function()
        local dap = require("dap")
        local get_python_path = function()
          local cwd = vim.fn.getcwd()
          local venv_python = cwd .. "/.venv/bin/python"
          if vim.fn.filereadable(venv_python) == 1 then
            return venv_python
          else
            return vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
          end
        end
        -- Default: current file
        local current_file = vim.api.nvim_buf_get_name(0)
        local target = vim.fn.input("Launch module or file (default: current file): ")
        if target == "" then
          target = current_file
        end
        -- Ask for args (optional)
        local args = vim.fn.input("Args (space separated, optional): ")
        local args_list = {}
        if args ~= "" then
          for word in args:gmatch("%S+") do
            table.insert(args_list, word)
          end
        end
        -- Build launch configuration
        local config = {
          type = "python",
          request = "launch",
          name = "Dynamic Launch: " .. target,
          console = "integratedTerminal",
          justMyCode = false,
          cwd = vim.fn.getcwd(),
          pythonPath = get_python_path,
        }
        -- Determine if target is a file or a module
        if target:match("%.py$") then
          config.program = target
          config.args = args_list
        else
          config.module = target
          -- Pass frozen modules flag for Python 3.13+
          table.insert(args_list, 1, "-Xfrozen_modules=off")
          config.args = args_list
        end
        dap.run(config)
      end, { noremap = true, silent = true })
      -- Step Over
      vim.keymap.set("n", "<leader>do", function()
        dap.step_over()
      end, opts)
      -- Step Into
      vim.keymap.set("n", "<leader>di", function()
        dap.step_into()
      end, opts)
      -- Step Out
      vim.keymap.set("n", "<leader>dO", function()
        dap.step_out()
      end, opts)
      -- Keymap to terminate debugging
      vim.keymap.set("n", "<leader>dq", function()
        require("dap").terminate()
      end, opts)
      -- Toggle DAP UI
      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end, opts)
      -- DAP configurations
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch FastAPI (src.main)",
          module = "src.main", -- run as a module
          pythonPath = get_python_path,
          console = "integratedTerminal",
          justMyCode = false,
          cwd = vim.fn.getcwd(), -- project root
          args = { "-Xfrozen_modules=off" },
        },
      }
    end,
  },
}
