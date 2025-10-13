return {
		cmd = {
			vim.fn.stdpath("data")
				.. "/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
		},
		filetypes = { "ps1" },
	}
