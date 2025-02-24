return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      require("config.dap-config")
    end,
  },
}
