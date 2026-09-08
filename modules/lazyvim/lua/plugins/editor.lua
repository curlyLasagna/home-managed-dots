return {
	-- Typst Preview
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		build = function()
			require("typst-preview").update()
		end,
	},

	-- Zen Mode
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {},
		keys = {
			{ "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
		},
	},
}
