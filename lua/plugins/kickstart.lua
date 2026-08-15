-- Opt-in plugins from the kickstart.nvim tree. They are require()d rather than
-- imported as a module so that lua/kickstart/plugins/lint.lua stays dormant and
-- lua/kickstart/health.lua (not a plugin spec) is not picked up.
return {
	require("kickstart.plugins.debug"),
	require("kickstart.plugins.indent_line"),
	-- require("kickstart.plugins.lint"),
	require("kickstart.plugins.autopairs"),
	require("kickstart.plugins.neo-tree"),
	require("kickstart.plugins.gitsigns"), -- adds gitsigns recommended keymaps
	require("kickstart.plugins.lualine"),
	require("kickstart.plugins.harpoon"),
	require("kickstart.plugins.markdown-preview"),
}
