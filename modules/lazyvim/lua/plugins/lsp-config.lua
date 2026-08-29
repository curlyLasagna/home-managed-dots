return {
	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = {
				enabled = true,
			},
			linters_by_ft = {
				nix = {},
			},
			servers = {
				ruff = {},
				ty = {},
				marksman = {},
				nixd = {},
				nil_ls = { enabled = false },
				tinymist = {},
				texlab = {},
				gopls = {},
			},
		},
	},
}
