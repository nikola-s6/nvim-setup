-- Statusline, modelled on the one LazyVim ships (which is what Omarchy's
-- preinstalled Neovim used):
--   mode | branch | root dir + diagnostics + filetype icon + path
--        | dap status + pending plugin updates + git diff
--        | progress + location | clock
--
-- LazyVim's version leans on LazyVim.lualine.*, Snacks and noice; none of those
-- are installed here, so root_dir/pretty_path/colors are reimplemented locally.

local icons = {
  diagnostics = { Error = " ", Warn = " ", Info = " ", Hint = " " },
  git = { added = " ", modified = " ", removed = " " },
}

--- Highlight foreground colour of a highlight group, for component colouring.
local function fg(name)
  return function()
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    local color = hl and hl.fg
    return color and { fg = string.format("#%06x", color) }
  end
end

--- Show the project root whenever it differs from the cwd.
local function root_dir()
  local function get()
    local buf = vim.api.nvim_get_current_buf()
    local root
    for _, client in pairs(vim.lsp.get_clients({ bufnr = buf })) do
      local workspace = client.config.workspace_folders
      if workspace and workspace[1] then
        root = vim.uri_to_fname(workspace[1].uri)
        break
      end
      if client.root_dir then
        root = client.root_dir
        break
      end
    end
    if not root then
      local found = vim.fs.find({ ".git", "lua", "package.json", "go.mod", "Cargo.toml" }, {
        path = vim.api.nvim_buf_get_name(buf),
        upward = true,
      })[1]
      root = found and vim.fs.dirname(found) or nil
    end
    return root
  end

  return {
    function()
      return "󱉭 " .. vim.fn.fnamemodify(get(), ":t")
    end,
    cond = function()
      local root = get()
      return root ~= nil and root ~= vim.uv.cwd()
    end,
    color = fg("Special"),
  }
end

--- Path relative to the cwd, with the filename highlighted, like LazyVim's.
local function pretty_path()
  return function()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" or vim.bo.buftype ~= "" then
      return ""
    end

    path = vim.fs.normalize(path)
    local cwd = vim.uv.cwd()
    if cwd and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local parts = vim.split(path, "/")
    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    local name = table.remove(parts)
    local prefix = #parts > 0 and (table.concat(parts, "/") .. "/") or ""
    local modified = vim.bo.modified and " ●" or ""

    return prefix .. "%#lualine_c_normal#" .. name .. modified
  end
end

return {
  -- Set lualine as statusline
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- See `:help lualine.txt`
  opts = function()
    -- One statusline for the whole editor instead of one per split; this is
    -- what makes the neo-tree + code layout look like LazyVim's.
    vim.o.laststatus = 3

    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            fmt = function(str)
              return str:sub(1, 20)
            end,
          },
        },
        lualine_c = {
          root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { pretty_path() },
        },
        lualine_x = {
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = fg("Debug"),
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = fg("Special"),
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
