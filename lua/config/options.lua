-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
require('config.remote_clipboard').setup()
vim.opt.relativenumber = false
vim.g.autoformat = false

-- Don't render trailing whitespace as "-". LazyVim's autoindent leaves real
-- indentation spaces on an otherwise blank line, and listchars was drawing
-- those as a dash that looked like typed text.
vim.opt.listchars:remove("trail")

-- Block cursor everywhere, including insert mode. Normal/visual/etc. use
-- the theme's own "Cursor" highlight; insert mode uses "CursorInsert"
-- instead, a fixed color regardless of theme (see autocmds.lua). No blink*
-- args means no blinking (blinkon0, the default).
vim.opt.guicursor = "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:block-CursorInsert/lCursorInsert,r-cr-o:hor20"
