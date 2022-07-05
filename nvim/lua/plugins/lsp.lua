-- Setup LSP
local servers = {
    'cssls',
    'emmet_ls',
    'html',
    'intelephense',
    'jsonls',
    'lemminx',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'tsserver',
    'jsonls',
    'vimls',
    'volar',
}

-- LSP Installer
require('nvim-lsp-installer').setup {
    automatic_installation = true,
    ensure_installed = servers,
    ui = {
        icons = {
            server_installed = '✓',
            server_pending = '➜',
            server_uninstalled = '✗',
        },
    },
}

-- Setup Gutter Signs
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure diagnostics
vim.diagnostic.config {
    virtual_text = false, -- Hide the diagnostics at the end of the line
}

-- Common attach function
local function common_attach(client, bufnr)
    -- Do common attach stuff here
    require('plugins.lualine').clear_cache()
    require('illuminate').on_attach(client)

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

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<C-space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
end

-- Default LSP flags for all serversr.
local default_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- Create capabilities
local cmplsp = require 'cmp_nvim_lsp'
local lspconfig = require 'lspconfig'
local capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable folding
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

-- Setup servers
for _, lsp in pairs(servers) do
    local opt = {
        capabilities = capabilities,
        on_attach = common_attach,
        flags = default_flags,
    }
    -- Add custom settings per server here
    if lsp == 'jsonls' then
        opt.settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        }
    elseif lsp == 'emmet_ls' then
        opt.filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'php' }
        capabilities.textDocument.completion.completionItem.snippetSupport = true
    end
    lspconfig[lsp].setup(opt)
end

-- Setup lua-dev
lspconfig.sumneko_lua.setup(require('lua-dev').setup {
    lspconfig = {
        cmd = { 'lua-language-server' },
        capabilities = capabilities,
        on_attach = common_attach,
    },
})

-- Setup null-ls
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local null_ls = require 'null-ls'
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.phpcsfixer.with {
            extra_args = {
                '--config',
                '/Users/swoo/.swoo-workspace/.php-cs-fixer.php',
            },
        },
        null_ls.builtins.formatting.prettierd.with {
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.config/.prettierrc.json',
            },
        },
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.stylelint,
    },
    on_attach = function(client, bufnr)
        common_attach(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    local util = require 'vim.lsp.util'
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
