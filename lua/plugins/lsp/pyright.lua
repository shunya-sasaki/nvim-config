return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
