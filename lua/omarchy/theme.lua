-- Omarchy theme integration.
--
-- `omarchy-theme-set` rebuilds ~/.local/state/omarchy/current/theme/ and the
-- `neovim.lua` inside it is a LazyVim plugin spec, e.g.
--
--   return {
--     { "ficcdaf/ashen.nvim" },
--     { "LazyVim/LazyVim", opts = { colorscheme = "ashen" } },
--   }
--
-- `lua/plugins/theme.lua` is a symlink to that file (see install.sh), so
-- lazy.nvim's reloader picks the change up within ~2s and fires `User
-- LazyReload`. This module reads the colorscheme name out of that spec and
-- applies it. The `LazyVim/LazyVim` half of the spec is neutralised by an
-- `enabled = false` stub in lua/plugins/omarchy-theme.lua.
--
-- Everything is guarded: without Omarchy (or with a broken theme file) we fall
-- back to FALLBACK_COLORSCHEME, so this config stays portable.

local M = {}

M.fallback = "tokyonight-night"

local function theme_file()
	return vim.fn.stdpath("config") .. "/lua/plugins/theme.lua"
end

local function transparency_file()
	return vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"
end

--- Read the Omarchy theme spec.
---@return { colorscheme: string, plugin: string? }?
function M.read()
	local file = theme_file()
	if vim.fn.filereadable(file) ~= 1 then
		return nil
	end

	local chunk = loadfile(file)
	if not chunk then
		return nil
	end

	local ok, spec = pcall(chunk)
	if not ok or type(spec) ~= "table" then
		return nil
	end

	local colorscheme, plugin
	for _, entry in ipairs(spec) do
		if type(entry) == "table" and type(entry[1]) == "string" then
			if entry[1] == "LazyVim/LazyVim" then
				if type(entry.opts) == "table" and type(entry.opts.colorscheme) == "string" then
					colorscheme = entry.opts.colorscheme
				end
			elseif not plugin then
				-- lazy.nvim keys plugins by the repo basename, not "owner/repo"
				plugin = entry.name or entry[1]:match("[^/]+$")
			end
		end
	end

	if not colorscheme then
		return nil
	end

	return { colorscheme = colorscheme, plugin = plugin }
end

--- Drop every cached lua module belonging to a plugin, so a reload rebuilds
--- its highlights from scratch instead of serving memoised colors.
local function unload_plugin_modules(plugin)
	local dir = plugin.dir and (plugin.dir .. "/lua")
	if not dir or vim.fn.isdirectory(dir) ~= 1 then
		return
	end
	pcall(function()
		require("lazy.core.util").walkmods(dir, function(modname)
			package.loaded[modname] = nil
			package.preload[modname] = nil
		end)
	end)
end

--- Make sure the plugin providing `colorscheme` is loaded, re-running its
--- setup() when it is already loaded (themes that share a plugin but differ in
--- opts, e.g. catppuccin vs catppuccin-latte, need the second setup call).
local function load_theme_plugin(info)
	local ok_config, Config = pcall(require, "lazy.core.config")
	local ok_loader, Loader = pcall(require, "lazy.core.loader")
	if not (ok_config and ok_loader) then
		return
	end

	local plugin = info.plugin and Config.plugins[info.plugin]
	if plugin and plugin._.loaded then
		unload_plugin_modules(plugin)
		pcall(Loader.reload, plugin)
	else
		if plugin then
			unload_plugin_modules(plugin)
		end
		pcall(Loader.colorscheme, info.colorscheme)
	end
end

--- Re-apply the transparency overrides on top of the fresh colorscheme.
function M.apply_transparency()
	local file = transparency_file()
	if vim.fn.filereadable(file) == 1 then
		pcall(vim.cmd.source, file)
	end
end

--- Apply the current Omarchy colorscheme (or the fallback).
---@param opts? { notify?: boolean }
function M.apply(opts)
	opts = opts or {}
	local info = M.read() or { colorscheme = M.fallback }

	-- Wipe the previous theme's highlights, and reset the background so that
	-- light themes (catppuccin-latte, flexoki-light, rose-pine-dawn, ...) can
	-- flip it themselves instead of inheriting "light" from the theme before.
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"

	load_theme_plugin(info)

	local ok = pcall(vim.cmd.colorscheme, info.colorscheme)
	if not ok and info.colorscheme ~= M.fallback then
		if opts.notify then
			vim.notify(
				("omarchy-theme: colorscheme %q is not available, using %s"):format(info.colorscheme, M.fallback),
				vim.log.levels.WARN
			)
		end
		pcall(vim.cmd.colorscheme, M.fallback)
	end

	M.apply_transparency()

	pcall(vim.api.nvim_exec_autocmds, "ColorScheme", { modeline = false })
	vim.cmd("redraw!")
end

function M.setup()
	M.apply()

	-- lazy.nvim's reloader polls the spec files every 2s; the theme symlink
	-- resolves to the file omarchy-theme-set just swapped in, so a theme change
	-- shows up here.
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyReload",
		group = vim.api.nvim_create_augroup("omarchy-theme-reload", { clear = true }),
		callback = function()
			vim.schedule(function()
				M.apply({ notify = true })
			end)
		end,
	})

	vim.api.nvim_create_user_command("OmarchyThemeReload", function()
		M.apply({ notify = true })
	end, { desc = "Re-apply the current Omarchy colorscheme" })
end

return M
