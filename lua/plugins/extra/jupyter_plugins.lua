return {
	-- {
	--     "benlubas/molten-nvim",
	--     version = "^1.0.0",
	--     dependencies = { "3rd/image.nvim" },
	--     build = ":UpdateRemotePlugins",
	--     init = function()
	--         -- these are examples, not defaults. Please see the readme
	--         vim.g.molten_image_provider = "image.nvim"
	--         vim.g.molten_output_win_max_height = 20
	--     end,
	-- },
	-- {
	--     "3rd/image.nvim",
	--     opts = {
	--         backend = "kitty",
	--         max_width = 100,
	--         max_height = 12,
	--         max_height_window_percentage = math.huge,
	--         max_width_window_percentage = math.huge,
	--         window_overlap_clear_enabled = true,
	--         window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	--     },
	-- },
	{
		"dccsillag/magma-nvim",
		build = ":UpdateRemotePlugins",
	},
	{
		"jupyter-vim/jupyter-vim",
		config = function()
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.py" },
				callback = function()
					vim.api.nvim_buf_set_keymap(
						0,
						"n",
						"<leader>r",
						":JupyterSendCell<CR>",
						{ silent = true, noremap = true }
					)
				end,
			})
			vim.g.jupyter_highlight_cells = 0
		end,
	},
}
