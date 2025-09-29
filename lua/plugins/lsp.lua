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
				"html",
				"powershell_es",
				"nginx_language_server",
			}
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configure LSP servers using vim.lsp.config
			vim.lsp.config.clangd = {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				capabilities = capabilities,
			}
			vim.lsp.config.csharp_ls = {
				cmd = { "csharp-ls" },
				filetypes = { "cs" },
				capabilities = capabilities,
			}
			vim.lsp.config.rust_analyzer = {
				cmd = { "rust-analyzer" },
				filetypes = { "rust" },
				capabilities = capabilities,
			}
			vim.lsp.config.pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				capabilities = capabilities,
			}
			vim.lsp.config.biome = {
				cmd = { "biome", "lsp-proxy" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"json",
					"jsonc",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
				},
				capabilities = capabilities,
			}
			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			}
			vim.lsp.config.tailwindcss = {
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"aspnetcorerazor",
					"astro",
					"astro-markdown",
					"blade",
					"clojure",
					"django-html",
					"htmldjango",
					"edge",
					"eelixir",
					"elixir",
					"ejs",
					"erb",
					"eruby",
					"gohtml",
					"gohtmltmpl",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"html-eex",
					"heex",
					"jade",
					"leaf",
					"liquid",
					"markdown",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					"php",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				capabilities = capabilities,
			}
			vim.lsp.config.marksman = {
				cmd = { "marksman", "server" },
				filetypes = { "markdown", "markdown.mdx" },
				capabilities = capabilities,
			}
			vim.lsp.config.powershell_es = {
				cmd = {
					vim.fn.stdpath("data")
						.. "/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
				},
				filetypes = { "ps1" },
				capabilities = capabilities,
			}

			-- Enable the LSP servers
			vim.lsp.enable("clangd")
			vim.lsp.enable("csharp_ls")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("pyright")
			vim.lsp.enable("biome")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("tailwindcss")
			vim.lsp.enable("marksman")
			vim.lsp.enable("powershell_es")
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
