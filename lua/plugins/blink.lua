-- Personal tweaks on top of LazyVim's blink.cmp setup.
--
-- Everything else (enter preset, <Tab>/<S-Tab> snippet navigation, auto
-- brackets, cmdline completion, treesitter-highlighted menu, native snippets
-- with friendly-snippets, Rust fuzzy matcher) is left as LazyVim ships it.
--
-- NOTE: an `opts` *function* is required here. LazyVim declares
-- `opts_extend = { "sources.default", ... }`, so a plain `opts` table would
-- append to the source list instead of replacing it.
return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    -- Suggest from the LSP and from paths only. Buffer words are noise now
    -- that real LSPs are attached, and snippets are on demand via <C-s>
    -- below rather than mixed into every completion list. (LazyVim still
    -- adds lazydev for Lua files.)
    local drop = { buffer = true, snippets = true }
    opts.sources = opts.sources or {}
    opts.sources.default = vim.tbl_filter(function(source)
      return not drop[source]
    end, opts.sources.default or { "lsp", "path" })

    -- Don't pop the documentation window open on its own; <C-space> shows it.
    opts.completion = opts.completion or {}
    opts.completion.documentation = vim.tbl_deep_extend("force", opts.completion.documentation or {}, {
      auto_show = false,
    })

    -- No inline "ghost text" preview of the top match — it reads like text
    -- that's already been typed. The completion popup itself stays as-is.
    opts.completion.ghost_text = vim.tbl_deep_extend("force", opts.completion.ghost_text or {}, {
      enabled = false,
    })

    -- Signature hints while typing arguments.
    opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, { enabled = true })

    -- <C-s>: open the completion menu with snippets only.
    opts.keymap = opts.keymap or {}
    opts.keymap["<C-s>"] = {
      function(cmp)
        return cmp.show({ providers = { "snippets" } })
      end,
      "fallback",
    }
  end,
}
