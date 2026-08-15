-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- kj: exit insert mode without reaching for <Esc>.
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- <leader>i: jump focus into the Neo-tree explorer (opening it if closed).
vim.keymap.set("n", "<leader>i", function()
  require("neo-tree.command").execute({ action = "focus" })
end, { desc = "Focus explorer" })

-- <leader>o: toggle the Neo-tree explorer open/closed.
vim.keymap.set("n", "<leader>o", function()
  require("neo-tree.command").execute({ toggle = true })
end, { desc = "Toggle explorer" })

-- ff: format the buffer, then save it.
vim.keymap.set("n", "ff", function()
  LazyVim.format({ force = true })
  vim.cmd("write")
end, { desc = "Format and save" })

-- <leader>m: see recent messages in full - cmdheight stays at 1 (no
-- permanently reserved space), so a multi-line message only shows its
-- last line live; this opens the full history on demand instead.
vim.keymap.set("n", "<leader>m", "<cmd>messages<cr>", { desc = "Show messages" })
