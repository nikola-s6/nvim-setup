return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = "|",
			section_separators = "",
		},
		sections = {
			lualine_a = { "mode" }, -- Show current mode (e.g., NORMAL, INSERT)
			lualine_b = {
				{
					"branch",
					fmt = function(str)
						return str:sub(1, 8)
					end,
				},
			},
			lualine_c = {
				{ "filename" }, -- Show relative file path
				-- { "navic" }, -- Show function names in lualine
			},
			lualine_x = {}, -- Empty section (removed encoding, fileformat, filetype)
			lualine_y = { "diagnostics", "diff" }, -- Empty section (removed progress)
			lualine_z = { "location" }, -- Show cursor location (line:column)
		},
	},
}
