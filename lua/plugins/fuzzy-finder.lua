return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--no-heading",
						"--no-ignore",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--glob=!**/.git/*",
						"--glob=!**/.venv/*",
						"--glob=!**/.mypy_cache/*",
						"--glob=!**/.pytest_cache/*",
						"--glob=!**/.next/*",
						"--glob=!**/__pycache__/*",
						"--glob=!**/packages/*",
						"--glob=!**/node_modules/*",
						"--glob=!**/dist/*",
						"--glob=!**/bin/*",
						"--glob=!**/build/*",
						"--glob=!**/out/*",
						"--glob=!**/globalStorage/*",
						"--glob=!**/workspaceStorage/*",
						"--glob=!**/History/*",
						"--glob=!**/.DS_Store",
					},
					mappings = {
						i = {
							["<Esc>"] = { actions.close, type = "action", opts = { nowait = true, silent = true } },
						},
					},
				},
				pickers = {
					find_files = {
						hidden = false,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--no-ignore",
							"--glob=!**/.git/*",
							"--glob=!**/.venv/*",
							"--glob=!**/.mypy_cache/*",
							"--glob=!**/.pytest_cache/*",
							"--glob=!**/.next/*",
							"--glob=!**/__pycache__/*",
							"--glob=!**/packages/*",
							"--glob=!**/node_modules/*",
							"--glob=!**/dist/*",
							"--glob=!**/bin/*",
							"--glob=!**/build/*",
							"--glob=!**/out/*",
							"--glob=!**/globalStorage/*",
							"--glob=!**/workspaceStorage/*",
							"--glob=!**/History/*",
							"--glob=!**/.DS_Store",
						},
					},
				},
			})
		end,
	},
}
