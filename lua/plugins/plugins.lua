return {
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
}
