local dap, dapui = require("dap"), require("dapui")

dap.set_log_level("DEBUG")

dap.adapters.netcoredbg = {
  type = "executable",
  command = "/Users/cbradford/.local/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
  {
    type = "coreclr",
    name = "attach - netcoredbg",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dapui.setup()
