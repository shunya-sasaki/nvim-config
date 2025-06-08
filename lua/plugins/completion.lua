return {
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
			{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build   = "make install_jsregexp",
			lazy = false,
			opts = {
				history = true,
				delete_check_events = "TextChanged", -- tidy up removed snippet text  [oai_citation:2‡github.com](https://github.com/L3MON4D3/LuaSnip?utm_source=chatgpt.com)
				},
			config = function(_, opts)
				local luasnip = require("luasnip")
				local vscode_snippets_path = {
					vim.fn.expand(vim.fn.stdpath("config") .. "/snippets"),
				}
				luasnip.setup(opts)
				require('luasnip.loaders.from_vscode').load({
					paths = vscode_snippets_path
				})
				end
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
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
