-- Auto-reload files changed on disk (works with LazyVim)
vim.opt.autoread = true

local grp = vim.api.nvim_create_augroup("AutoReadOnFocus", { clear = true })

-- When you tab back to Neovim, pause typing, or enter a buffer, check for changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = grp,
  command = "checktime",
})

-- Nice heads-up when something got reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = grp,
  callback = function(args)
    vim.notify(("Reloaded %s (changed on disk)"):format(vim.fn.fnamemodify(args.file, ":.")), vim.log.levels.WARN, {
      title = "Auto Read",
    })
  end,
})
