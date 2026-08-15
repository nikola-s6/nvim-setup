-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Insert-mode cursor is always purple; every other mode keeps the theme's
-- own cursor color (unchanged, driven by the "Cursor" highlight group in
-- guicursor, see options.lua). Re-applied on every ColorScheme event
-- because theme switching (omarchy-theme-hotreload.lua) runs
-- `:highlight clear`, which would otherwise wipe this out.
local function set_insert_cursor_hl()
  vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#c678dd", fg = "#ffffff" })
end
set_insert_cursor_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("insert_cursor_hl", { clear = true }),
  callback = set_insert_cursor_hl,
})
