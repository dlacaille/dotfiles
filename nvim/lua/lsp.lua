local M = {}

local lualine = require 'plugins.config.lualine'
local navic = require 'nvim-navic'
local document_color = require 'document-color'
local cmplsp = require 'cmp_nvim_lsp'
local lspconfig = require 'lspconfig'
local luadev = require 'lua-dev'
local null_ls = require 'null-ls'
local util = require 'vim.lsp.util'
local schemastore = require 'schemastore'
local installer = require 'nvim-lsp-installer'

-- Setup LSP
M.servers = {
    'cssls',
    'html',
    'intelephense',
    'jsonls',
    'lemminx',
    'sumneko_lua',
    'tailwindcss',
    'tsserver',
    'volar',
}

-- M.signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
M.signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

-- Default LSP flags for all servers.
M.default_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

function M.common_attach(client, bufnr)
    -- Do common attach stuff here
    lualine.clear_cache()

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end,
    })

    if client.server_capabilities.colorProvider then
        -- Attach document colour support
        document_color.buf_attach(bufnr)
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<C-space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
end

function M.setup()
    -- LSP Installer
    installer.setup {
        automatic_installation = true,
        ensure_installed = M.servers,
        ui = {
            icons = {
                server_installed = '✓',
                server_pending = '➜',
                server_uninstalled = '✗',
            },
        },
    }

    -- Setup Gutter Signs
    for type, icon in pairs(M.signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Configure diagnostics
    vim.diagnostic.config {
        virtual_text = true,
        signs = true,
    }

    -- Create capabilities
    local capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Enable folding
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    -- Setup servers
    for _, lsp in pairs(M.servers) do
        local opt = {
            capabilities = capabilities,
            on_attach = M.common_attach,
            flags = M.default_flags,
        }
        -- Add custom settings per server here
        if lsp == 'jsonls' then
            opt.settings = {
                json = {
                    schemas = schemastore.json.schemas(),
                    validate = { enable = true },
                },
            }
        end
        lspconfig[lsp].setup(opt)
    end

    -- Setup lua-dev
    lspconfig.sumneko_lua.setup(luadev.setup {
        lspconfig = {
            cmd = { 'lua-language-server' },
            capabilities = capabilities,
            on_attach = M.common_attach,
        },
    })

    -- Setup null-ls
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
        sources = {
            null_ls.builtins.formatting.phpcsfixer.with {
                extra_args = {
                    '--config',
                    vim.fn.expand '~/.swoo-workspace/.php-cs-fixer.php',
                },
            },
            null_ls.builtins.formatting.prettierd.with {
                env = {
                    PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.config/.prettierrc.json',
                },
            },
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.eslint_d,
        },
        on_attach = function(client, bufnr)
            M.common_attach(client, bufnr)
            if client.supports_method 'textDocument/formatting' then
                vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        local params = util.make_formatting_params {}
                        local result, err = client.request_sync('textDocument/formatting', params, 5000, bufnr)
                        if result and result.result then
                            util.apply_text_edits(result.result, bufnr, client.offset_encoding)
                        elseif err then
                            vim.notify('vim.lsp.buf.formatting_sync: ' .. err, vim.log.levels.WARN)
                        end
                    end,
                })
            end
        end,
    }
end

return M
