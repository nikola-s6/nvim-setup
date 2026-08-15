-- User commands.

-- Delete entries by their QUICKFIX LIST line numbers (e.g., :Qfd 3,5,7)
vim.api.nvim_create_user_command("Qfd", function(opts)
	local args = opts.args
	if args == "" then
		print("Usage: :Qfd <line1>,<line2>,... (e.g., :Qfd 3,5,7)")
		return
	end

	-- Parse input (e.g., "3,5,7" → {3, 5, 7})
	local lines_to_delete = {}
	for num in string.gmatch(args, "(%d+)") do
		table.insert(lines_to_delete, tonumber(num))
	end

	-- Get current quickfix list
	local qf_list = vim.fn.getqflist()

	-- Filter out entries at the specified QUICKFIX LIST lines
	local new_qf = {}
	for i, item in ipairs(qf_list) do
		if not vim.tbl_contains(lines_to_delete, i) then
			table.insert(new_qf, item)
		end
	end

	-- Update quickfix list (and preserve cursor position)
	vim.fn.setqflist({}, "r", { items = new_qf })
	print(string.format("Removed quickfix lines: %s", args))
end, { nargs = "?", desc = "Delete quickfix entries by their list position" })

-- Kill the prettierd daemon so it re-reads .prettierrc on next save.
-- Run this after editing a project's .prettierrc if formatting still uses old settings.
vim.api.nvim_create_user_command("PrettierdRestart", function()
	vim.fn.jobstart({ "pkill", "-f", "prettierd" }, {
		on_exit = function(_, code)
			vim.schedule(function()
				if code == 0 or code == 1 then
					vim.notify("prettierd killed — next save will reload .prettierrc", vim.log.levels.INFO)
				else
					vim.notify("pkill failed with exit code " .. code, vim.log.levels.ERROR)
				end
			end)
		end,
	})
end, { desc = "Kill prettierd daemon to force .prettierrc reload" })
