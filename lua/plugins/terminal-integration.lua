return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

			function Lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>g",
				"<cmd>lua Lazygit_toggle()<CR>",
				{ noremap = true, silent = true }
			)
			require("toggleterm").setup({ direction = "float" })
			vim.api.nvim_set_keymap("n", "<C-t>", ": ToggleTerm<CR>", { silent = true, noremap = true })
		end,
	},
}
