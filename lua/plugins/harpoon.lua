-- Harpoon setup and keymaps. The plugin spec itself comes from
-- lua/kickstart/plugins/harpoon.lua (branch harpoon2); lazy.nvim merges the two.
return {
	"ThePrimeagen/harpoon",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon add to list" })
		vim.keymap.set("n", "<leader>hx", function()
			harpoon:list():remove()
		end, { desc = "Harpoon remove from list" })
		vim.keymap.set("n", "<leader>p", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon show list" })
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon first file" })
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon second file" })
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon third file" })
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon fourth file" })
		vim.keymap.set("n", "H", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "L", function()
			harpoon:list():next()
		end)
	end,
}
