-- Personal tweaks on top of LazyVim's LSP setup.
return {
  "neovim/nvim-lspconfig",
  opts = {
    -- No inlay hints anywhere: parameter names, return types, etc. are
    -- inferred text the LSP is guessing at, not real code, and it's easy to
    -- mistake for something actually written. Toggle on demand with <leader>uh
    -- if a specific spot calls for it.
    inlay_hints = { enabled = false },
  },
}
