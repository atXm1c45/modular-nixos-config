return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			-- Mini Icons
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()

			-- Mini Pairs
			require("mini.pairs").setup()

			-- Mini Comments
			require("mini.comment").setup()

			-- Mini Surround
			require("mini.surround").setup()

			-- Mini Files
			require("mini.files").setup({
				windows = {
					preview = true, -- Show preview of file when hovering
					width_focus = 30,
					width_preview = 80,
				},
				mappings = {
					go_in = "<Right>", -- Map Right Arrow to 'Enter Folder'
					go_in_plus = "<CR>", -- Map Enter to 'Enter Folder' (VS Code style)
					go_out = "<Left>", -- Map Left Arrow to 'Go Back'
					go_out_plus = "<BS>", -- Map Backspace to 'Go Back'
					reset = "<BS>", -- Backspace to reset path
				},
			})

			vim.keymap.set("n", "<leader>fm", function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end, { desc = "Open Mini Files" })
		end,
	},
}
