-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true })
-- Normal & Visual mappings
vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat<cr>", { desc = "AI: Open Chat" })
vim.keymap.set("n", "<leader>ak", "<cmd>CodeCompanion<cr>", { desc = "AI: Inline Assistant" })
-- Inline with prompt after selection (visual mode)
vim.keymap.set("v", "<leader>ak", ":CodeCompanion ", { desc = "AI: Inline Assistant with Prompt" })
