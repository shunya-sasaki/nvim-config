return {
	-- fuzzy finder ===========================================================
	-- telescope --------------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
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
						"--glob=!**/.next/*",
						"--glob=!**/pcackages/*",
						"--glob=!**/node_modules/*",
						"--glob=!**/dist/*",
						"--glob=!**/bin/*",
						"--glob=!**/build/*",
						"--glob=!**/out/*",
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
							"--glob=!**/.next/*",
							"--glob=!**/packages/*",
							"--glob=!**/node_modules/*",
							"--glob=!**/dist/*",
							"--glob=!**/bin/*",
							"--glob=!**/build/*",
							"--glob=!**/out/*",
						},
					},
				},
			})
		end,
	},
	-- syntax =================================================================
	-- treesitter (syntax) ----------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"c_sharp",
					"cmake",
					"css",
					"diff",
					"doxygen",
					"fortran",
					"git_config",
					"gitcommit",
					"gitignore",
					"html",
					"htmldjango",
					"ini",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"mermaid",
					"nginx",
					"powershell",
					"python",
					"razor",
					"requirements",
					"rust",
					"sql",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
			vim.filetype.add({
				extension = {
					mdx = "markdown",
					razor = "razor",
				},
			})
		end,
	},
	-- terminal ===============================================================
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
	-- git ====================================================================
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- auto pair
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- comment
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	-- surround
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- easymotion
	{
		"phaazon/hop.nvim",
		config = function()
			local hop = require("hop")
			vim.keymap.set("n", "<Leader><Leader>s", function()
				hop.hint_char1()
			end, { noremap = true, silent = true })
			hop.setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	-- preview ================================================================
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
