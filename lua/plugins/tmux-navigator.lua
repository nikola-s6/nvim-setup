-- Seamless <C-h/j/k/l> between Neovim splits and tmux panes. The tmux side is
-- the matching TPM plugin in tmux.conf. Ported from the old kickstart config.
--
-- Declaring the keys here (rather than in keymaps.lua) makes LazyVim's own
-- <C-h/j/k/l> window maps step aside: LazyVim.safe_keymap_set skips any lhs
-- that lazy.nvim already owns as a plugin key.
return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux/Window Left" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux/Window Down" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux/Window Up" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux/Window Right" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Tmux/Window Previous" },
	},
}
