return {
	{
	"L3MON4D3/LuaSnip",
	version = "2.*",
	build   = "make install_jsregexp",
	config = function()
		local vscode_snippets_path = nil
		local luasnip = require("luasnip")
		if Config.os_name == "win32" or Config.os_name == "win64" then
			vscode_snippets_path = vim.fn.expand("~\\AppData\\Roaming\\Code\\User\\snippets")
		elseif Config.os_name == "mac" then
			vscode_snippets_path = vim.fn.expand(os.getenv("HOME") .. "/Library/Application Support/Code/User/snippets")
		else
			vscode_snippets_path = vim.fn.expand("~/.config/Code/User/snippets")
		end
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vscode_snippets_path,
				vim.fn.stdpath("config") .. "/snippets"
			},
		})
		end
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"petertriho/cmp-git",
		},
		config = function()
			local cmp = require("cmp")
			-- Debug
			print("snips:", vim.inspect(require("luasnip").snippets))

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				-- Key mappings.
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-w>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
			})
			-- Use git source for commit messages.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
					{ name = "buffer" },
				}),
			})
			require("cmp_git").setup()
			-- Use buffer source for `/` and `?` cmdline.
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
}
