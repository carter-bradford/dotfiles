return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "LazyVim/LazyVim",
    },
    opts = function()
      -- Load your custom DAP configurations
      require("config.dap-config")
    end,
  },
}
