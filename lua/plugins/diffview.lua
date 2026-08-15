return {
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		init = function()
			vim.keymap.set("n", "<leader>hd", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
			vim.keymap.set("n", "<leader>hD", ":DiffviewClose<CR>", { desc = "Close Diffview" })
		end,
	},
}
