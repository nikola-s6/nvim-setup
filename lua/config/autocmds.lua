-- Autocommands and filetype tweaks.

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		-- vim.highlight was renamed to vim.hl in nvim 0.11
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Set up filetype detection for templ files
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

-- open neotree on startup
vim.api.nvim_create_autocmd("VimEnter", {
	command = "Neotree toggle",
})

-- Insert-mode cursor colour. Re-applied on every colorscheme change, since
-- switching Omarchy themes clears all highlight groups.
local cursor_group = vim.api.nvim_create_augroup("insert-cursor-highlight", { clear = true })

local function set_insert_cursor_hl()
	vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#c678dd", fg = "#FFFFFF" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = cursor_group,
	callback = set_insert_cursor_hl,
})

set_insert_cursor_hl()
