-- Put the command line and messages back where stock Neovim has them.
--
-- LazyVim enables noice's floating cmdline (the "command palette" popup in the
-- middle of the screen) and routes :messages through notifications.
return {
  "folke/noice.nvim",
  opts = {
    -- Classic cmdline at the bottom instead of the popup.
    cmdline = {
      view = "cmdline",
      format = {
        -- vim.ui.input() (LSP rename, etc.) defaults to its own floating
        -- "cmdline_input" view, centered on screen - point it at the same
        -- bottom cmdline instead.
        input = { view = "cmdline" },
      },
    },

    -- confirm()/:confirm dialogs (y/n-style questions) default to a
    -- floating popup near the top of the screen - move it to the bottom,
    -- same place as the cmdline.
    views = {
      confirm = {
        relative = "editor",
        position = { row = "100%", col = 0 },
        size = { width = "100%", height = "auto" },
        border = { style = "none" },
      },
    },

    -- Let Neovim handle messages itself (bottom of the screen, :messages
    -- history, "Press ENTER" prompts) instead of turning them into popups.
    messages = {
      enabled = false,
    },

    -- notify() is a separate mechanism from `messages` above - noice
    -- otherwise still hijacks vim.notify() into its own floating,
    -- auto-dismissing popup regardless of the messages setting. Disabling
    -- it here lets vim.notify() fall through to plain :messages too (no
    -- popup at all, since Snacks' notifier is also off).
    notify = {
      enabled = false,
    },

    -- Only repositions the popup cmdline, which is no longer used.
    presets = {
      command_palette = false,
    },
  },
}
