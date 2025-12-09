return {
	-- The Main Autocompletion Plugin
	"hrsh7th/nvim-cmp",

	-- Load these dependencies BEFORE running the config
	dependencies = {
		"hrsh7th/cmp-cmdline", -- Command line completions
		"hrsh7th/cmp-buffer", -- Buffer completions (text in current file)
		"hrsh7th/cmp-path", -- File path completions
	},

	-- The Configuration Logic
	config = function()
		local cmp = require("cmp")

		-- 1. Setup standard completion (if you haven't already in init.lua)
		-- If you already have a main cmp setup elsewhere, you can remove this block
		-- but keeping it here makes this file self-contained.
		cmp.setup({
			sources = cmp.config.sources({
				{ name = "path" }, -- Enable path completion
				{ name = "buffer" }, -- Enable buffer completion
			}),
		})

		-- 2. Setup Command Line ("/") Search Completion
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" }, -- Suggest text from the current buffer
			},
		})

		-- 3. Setup Command Line (":") Command Completion
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" }, -- Suggest file paths
			}, {
				{
					name = "cmdline", -- Suggest vim commands (:w, :q, etc)
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
