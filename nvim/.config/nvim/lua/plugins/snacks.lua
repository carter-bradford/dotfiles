return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.files = opts.picker.sources.files or { hidden = true }
    opts.picker.sources.files.hidden = true
    opts.picker.sources.explorer = opts.picker.sources.explorer or { hidden = true }
    opts.picker.sources.explorer.hidden = true

    opts.image = opts.image or {}
    opts.dashboard = { enabled = false }

    opts.lazygit = opts.lazygit or {}
    opts.lazygit.theme = vim.tbl_deep_extend("force", opts.lazygit.theme or {}, {
      activeBorderColor = { fg = "MatchParen", bold = true },
      inactiveBorderColor = { fg = "99a4bf" },
    })
  end,
}
