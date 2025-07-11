-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>o", ":Neotree toggle reveal=true<CR>", desc = "NeoTree toggle", silent = true },
		{ "<leader>i", ":Neotree focus reveal=true<CR>", desc = "NeoTree focus", silent = true },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
					["l"] = "open",
				},
			},
		},
	},
}
