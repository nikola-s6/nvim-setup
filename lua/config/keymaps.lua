-- Keymaps that don't belong to a specific plugin.
--
-- Loaded *before* lazy.nvim, so plugin mappings registered during startup (for
-- example vim-tmux-navigator's <C-hjkl>) take precedence over the ones here.
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize splits with CTRL+<arrows> (e.g. widen/narrow the neo-tree sidebar)
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.keymap.set("n", "ff", ":w<CR>", { desc = "Save file" })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "J", ":m .+1<CR>==", { noremap = true, silent = true }) -- move line down(n)
vim.api.nvim_set_keymap("n", "K", ":m .-2<CR>==", { noremap = true, silent = true }) -- move line up(n)
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true }) -- move line down(v)
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true }) -- move line down(v)

-- used to see recent messages
vim.keymap.set("n", "<leader>m", ":messages<CR>", { noremap = true, silent = true })

-- Project wide search and replace with confirmation
vim.keymap.set("n", "<leader>rr", function()
	local search = vim.fn.input("Search for: ")
	local filePattern = vim.fn.input("File pattern:")
	if search == "" then
		return
	end
	local replace = vim.fn.input("Replace with: ")
	vim.cmd(":vimgrep /" .. search .. "/gj **/" .. filePattern) -- Search all files
	vim.cmd(":copen") -- Open Quickfix list
	vim.cmd(":cfdo %s/" .. search .. "/" .. replace .. "/gc | update") -- Replace with confirmation
end, { desc = "Interactive project-wide search & replace" })
