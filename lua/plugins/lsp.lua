return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
		},
		opts = function(_, opts)
			opts.automatic_installation = true
			opts.ensure_installed = {
				"clangd",
				"cmake",
				"csharp_ls",
				"rust_analyzer",
				"taplo",
				"pyright",
				"ruff",
				"ty",
				"biome",
				"ts_ls",
				"tailwindcss",
				"cssls",
				"marksman",
				"powershell_es",
				"nginx_language_server",
			}
			lspconfig = require("lspconfig")
			capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.biome.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
			lspconfig.powershell_es.setup({
				capabilities = capabilities,
			})
			opts.handlers = {
				["tsserver"] = function()
					require("lspconfig").tsserver.setup({
						on_attach = function(client, bufnr)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
					})
				end,
			}
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"cpplint",
				"clang-format",
				"csharpier",
				"prettier",
				"stylua",
				"shfmt",
			},
		},
		dependencies = { "nvimtools/none-ls.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvimtools/none-ls-extras.nvim" },
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = {
				require("none-ls.diagnostics.cpplint"),
				null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh", "ksh", "csh" } }),
				null_ls.builtins.formatting.clang_format.with({ filetypes = { "c", "cpp", "h", "hpp" } }),
				null_ls.builtins.formatting.csharpier.with({ filetypes = { "cs" } }),
				null_ls.builtins.formatting.stylua.with({ filetypes = { "lua" } }),
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "markdown", "html" },
					extra_args = { "--ignore-path", ".prettierignore" },
				}),
			}
			opts.on_init = function(new_client, _)
				new_client.offset_encoding = "utf-16"
			end
		end,
	},
}
