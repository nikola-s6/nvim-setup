-- return {
-- 	{
-- 		"lukas-reineke/indent-blankline.nvim",
-- 		main = "ibl",
-- 		---@module "ibl"
-- 		---@type ibl.config
-- 		opts = {},
-- 	},
-- }
--
-- color indent lines
-- return {
-- 	{
-- 		"lukas-reineke/indent-blankline.nvim",
-- 		opts = {
-- 			indent = {
-- 				highlight = {
-- 					"FirstLevel",
-- 					"SecondLevel",
-- 					"ThirdLevel",
-- 					"FourthLevel",
-- 					"FifthLevel",
-- 					"SixtLevel",
-- 				},
-- 			},
-- 			scope = {
-- 				enabled = true,
-- 				show_start = false,
-- 				highlight = {
-- 					"Primary",
-- 				},
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			-- paste the hooks code here
-- 			-- change the setup() call to:
-- 			local hooks = require("ibl.hooks")
-- 			-- create the highlight groups in the highlight setup hook, so they are reset
-- 			-- every time the colorscheme changes
-- 			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- 				vim.api.nvim_set_hl(0, "Primary", { fg = "#c678dd" })
-- 				vim.api.nvim_set_hl(0, "FirstLevel", { fg = "#474e74" })
-- 				vim.api.nvim_set_hl(0, "SecondLevel", { fg = "#532f78" })
-- 				vim.api.nvim_set_hl(0, "ThirdLevel", { fg = "#38668c" })
-- 				vim.api.nvim_set_hl(0, "FourthLevel", { fg = "#878735" })
-- 				vim.api.nvim_set_hl(0, "FifthLevel", { fg = "#2d7569" })
-- 				vim.api.nvim_set_hl(0, "SixtLevel", { fg = "#873540" })
-- 			end)
-- 			require("ibl").setup(opts)
-- 		end,
-- 	},
-- }
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
			},
			scope = {
				char = "▏",
				enabled = true,
				show_start = false,
				highlight = {
					"Primary",
				},
			},
		},
		config = function(_, opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "Primary", { fg = "#c678dd" })
				vim.api.nvim_set_hl(0, "FirstLevel", { fg = "#474e74" })
				vim.api.nvim_set_hl(0, "SecondLevel", { fg = "#532f78" })
				vim.api.nvim_set_hl(0, "ThirdLevel", { fg = "#38668c" })
				vim.api.nvim_set_hl(0, "FourthLevel", { fg = "#878735" })
				vim.api.nvim_set_hl(0, "FifthLevel", { fg = "#2d7569" })
				vim.api.nvim_set_hl(0, "SixtLevel", { fg = "#873540" })
			end)
			require("ibl").setup(opts)
		end,
	},
}
