-- Omarchy live theme switching. See lua/omarchy/theme.lua for the details.
--
-- `lua/plugins/theme.lua` (created by install.sh) is a symlink to Omarchy's
-- current theme spec. That spec is written for LazyVim, so it always contains a
-- `{ "LazyVim/LazyVim", opts = { colorscheme = ... } }` entry. We don't use
-- LazyVim, so declare it disabled: lazy.nvim then never installs or loads it,
-- and we read the colorscheme out of the file ourselves.

return {
	{ "LazyVim/LazyVim", enabled = false },

	{
		"omarchy-theme",
		dir = vim.fn.stdpath("config"),
		name = "omarchy-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("omarchy.theme").setup()
		end,
	},
}
