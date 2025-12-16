return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		--  This function gets run when an LSP attaches to a particular buffer.

		vim.api.nvim_create_autocmd("LspAttach", {

			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.

				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.

				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.

				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.

				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.

				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor.

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action.

				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Goto Declaration.

				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- The following two autocommands are used to highlight references of the

				-- word under your cursor when your cursor rests there for a little while.

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {

						buffer = event.buf,

						group = highlight_augroup,

						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {

						buffer = event.buf,

						group = highlight_augroup,

						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {

						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),

						callback = function(event2)
							vim.lsp.buf.clear_references()

							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Create new capabilities with nvim cmp, and then broadcast that to the servers.

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers

		local servers = {

			ts_ls = {},

			ruff = {},

			pylsp = {

				settings = {

					pylsp = {

						plugins = {

							pyflakes = { enabled = false },

							pycodestyle = { enabled = false },

							autopep8 = { enabled = false },

							yapf = { enabled = false },

							mccabe = { enabled = false },

							pylsp_mypy = { enabled = false },

							pylsp_black = { enabled = false },

							pylsp_isort = { enabled = false },
						},
					},
				},
			},

			html = { filetypes = { "html", "twig", "hbs" } },

			cssls = {},

			tailwindcss = {},

			dockerls = {},

			sqlls = {},

			terraformls = {},

			jsonls = {},

			yamlls = {},

			qmlls = {
				cmd = { "/usr/bin/qmlls6", "-E" },

				filetypes = { "qml", "qtquick" },
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern(".git", "shell.qml", "qmldir")(fname)
						or vim.fn.getcwd()
				end,
			},

			-- === FIXED LUA CONFIG ===

			lua_ls = {

				-- Force system binary to fix Error 127

				cmd = { "/usr/bin/lua-language-server" },

				settings = {

					Lua = {

						completion = { callSnippet = "Replace" },

						runtime = { version = "LuaJIT" },

						workspace = {

							checkThirdParty = false,

							library = vim.api.nvim_get_runtime_file("", true),
						},

						diagnostics = {

							globals = { "vim" },

							disable = { "missing-fields" },
						},

						format = { enable = false },
					},
				},
			},
		}

		require("mason").setup()

		-- Get the list of servers we want to configure
		local ensure_installed = vim.tbl_keys(servers or {})

		-- FILTER: Remove 'lua_ls' from this list so Mason doesn't try to download it
		-- (We are using the system version instead)
		ensure_installed = vim.tbl_filter(function(name)
			return name ~= "lua_ls" and name ~= "qmlls"
		end, ensure_installed)

		vim.list_extend(ensure_installed, {
			"stylua",
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		-- === FIXED HANDLER SETUP (Fixes the "deprecated" error) ===

		require("mason-lspconfig").setup({

			handlers = {

				function(server_name)
					local server = servers[server_name] or {}

					-- Merge capabilities

					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					-- Use the handler to setup the server

					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
