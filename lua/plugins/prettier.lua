-- Format JS/TS/CSS/etc. with prettierd (respects the project's .prettierrc,
-- e.g. skeleton-test's `"semi": true`) instead of falling back to the LSP's
-- own built-in formatter, which ignores Prettier config entirely.
local filetypes = {
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettierd" } },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(filetypes) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettierd")
      end
    end,
  },
}
