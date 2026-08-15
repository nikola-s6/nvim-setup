return {
	{
		"voldikss/vim-floaterm",
		init = function()
			vim.g.floaterm_width = 0.99
			vim.g.floaterm_height = 0.99
			vim.g.floaterm_wintype = "float"
			vim.g.floaterm_position = "center"
			vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

			-- floaterm setup to work with lazygit
			vim.api.nvim_set_keymap(
				"n",
				"<leader>gi",
				":wall<CR> :FloatermNew --name=lazygit lazygit<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
