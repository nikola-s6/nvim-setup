return {
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" }, -- Ensure LSP is configured
		config = function()
			require("nvim-navic").setup({
				highlight = true, -- Highlight the current context
				separator = " > ", -- Separator between context levels
				safe_output = true,
			})
		end,
	},
}
