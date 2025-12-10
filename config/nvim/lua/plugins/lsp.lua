return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Removed Mason/Mason-Lspconfig/Mason-Tool-Installer/None-Ls

        -- Essential Status and Completion Plugins (kept)
        { "j-hui/fidget.nvim", opts = {} },
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        -- NOTE: All server definitions (luals, ts_ls, nil_ls, etc.) are now done below,
        -- outside the 'LspAttach' block, using vim.lsp.config['server'] = {}

        local caps = require("cmp_nvim_lsp").default_capabilities()
        local root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }

        -- === 1. GLOBAL & DIAGNOSTIC CONFIGURATION ===

        -- Sets global root marker default for LSPs
        vim.lsp.config('*', { root_markers = { '.git' } })

        -- Custom diagnostic symbols and float window behavior
        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = {
                style = 'minimal',
                border = 'rounded',
                source = 'if_many',
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = '»',
                },
            },
        })

        -- Custom function to apply rounded border to all hover/float windows
        local orig = vim.lsp.util.open_floating_preview
        ---@diagnostic disable-next-line: duplicate-set-field
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or 'rounded'
            opts.max_width = opts.max_width or 80
            opts.max_height = opts.max_height or 24
            opts.wrap = opts.wrap ~= false
            return orig(contents, syntax, opts, ...)
        end

        -- === 2. LSP SERVER DEFINITIONS (Replaces Mason Defaults) ===

        -- LUA (luals)
        vim.lsp.config['luals'] = {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
            capabilities = caps,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                },
            },
        }

        -- NIX (nil) - Uses system formatter (alejandra/nixpkgs-fmt)
        vim.lsp.config['nil_ls'] = {
            cmd = { 'nil' },
            filetypes = { 'nix' },
            root_markers = { 'flake.nix', 'default.nix', '.git' },
            capabilities = caps,
            settings = {
                ['nil'] = {
                    formatting = {
                        command = { "alejandra" } -- Use your preferred Nix formatter
                    }
                }
            }
        }

        -- TYPESCRIPT (ts_ls)
        vim.lsp.config['ts_ls'] = {
            cmd = { 'typescript-language-server', '--stdio' },
            filetypes = {
                'javascript', 'javascriptreact', 'javascript.jsx',
                'typescript', 'typescriptreact', 'typescript.tsx',
            },
            root_markers = root_markers,
            capabilities = caps,
        }

        -- CSS / TAILWIND
        vim.lsp.config['cssls'] = {
            cmd = { 'vscode-css-language-server', '--stdio' },
            filetypes = { 'css', 'scss', 'less' },
            root_markers = root_markers,
            capabilities = caps,
        }
        vim.lsp.config['tailwindcss'] = {
            -- Command usually set by Mason, use standard LSP definition
            filetypes = { 'css', 'scss', 'less', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
            root_markers = root_markers,
            capabilities = caps,
        }

        -- PYTHON (pylsp)
        vim.lsp.config['pylsp'] = {
            cmd = { 'pylsp' },
            filetypes = { 'python' },
            root_markers = root_markers,
            capabilities = caps,
        }

        -- DOCKER, TERRAFORM, JSON, YAML (Using defaults)
        vim.lsp.config['dockerls'] = { cmd = { 'docker-langserver', '--stdio' }, root_markers = root_markers, capabilities =
        caps }
        vim.lsp.config['terraformls'] = { cmd = { 'terraform-ls', 'serve' }, root_markers = root_markers, capabilities =
        caps }
        vim.lsp.config['jsonls'] = { root_markers = root_markers, capabilities = caps }
        vim.lsp.config['yamlls'] = { root_markers = root_markers, capabilities = caps }

        -- QML / QT (qmlls)
        -- vim.lsp.config['qmlls'] = {
        --     cmd = { "/usr/bin/qmlls6", "-E" },
        --     filetypes = { "qml", "qtquick" },
        --     capabilities = caps,
        -- }


        -- === 3. LSP ATTACH (Keymaps & Formatting Logic) ===

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                local buf = args.buf
                local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

                -- Keymaps (Unified set)
                map('n', 'K', vim.lsp.buf.hover)
                map('n', 'gd', vim.lsp.buf.definition)
                map('n', 'gD', vim.lsp.buf.declaration)
                map('n', 'gi', vim.lsp.buf.implementation)
                map('n', 'go', vim.lsp.buf.type_definition)
                map('n', 'gr', vim.lsp.buf.references)
                map('n', 'gs', vim.lsp.buf.signature_help)
                map('n', 'gl', vim.diagnostic.open_float)
                map('n', '<F2>', vim.lsp.buf.rename)
                map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
                map('n', '<F4>', vim.lsp.buf.code_action)

                -- Auto-format on save (only if server supports formatting)
                if client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('my.lsp.format', { clear = true }),
                        buffer = buf,
                        callback = function()
                            -- Use the client ID to ensure formatting request comes from the right server
                            vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
                        end,
                    })
                end
            end,
        })

        -- === 4. ENABLE SERVERS ===
        -- Enable all servers you defined above
        vim.lsp.enable('luals')
        vim.lsp.enable('cssls')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('nil_ls')
        vim.lsp.enable('pylsp')
        vim.lsp.enable('tailwindcss')
        vim.lsp.enable('dockerls')
        vim.lsp.enable('terraformls')
        vim.lsp.enable('jsonls')
        vim.lsp.enable('yamlls')
        -- vim.lsp.enable('qmlls')
    end,
}
