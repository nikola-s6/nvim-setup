-- Fallback colorscheme; the active one is chosen by lua/omarchy/theme.lua.
return {
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})

			-- NOTE: the colorscheme is applied by lua/omarchy/theme.lua, which follows
			-- the current Omarchy theme and falls back to tokyonight-night when there
			-- is no Omarchy theme on this machine.
		end,
	},
}
