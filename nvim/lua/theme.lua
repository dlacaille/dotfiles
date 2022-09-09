local M = {}

function M.setup()
    vim.g.tokyonight_style = 'night'
    vim.g.tokyonight_day_brightness = 0.3
    vim.g.tokyonight_sidebars = { 'Outline' }

    vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

    require('catppuccin').setup {
        integrations = {
            native_lsp = {
                underlines = {
                    errors = { 'undercurl' },
                    hints = { 'undercurl' },
                    warnings = { 'undercurl' },
                    information = { 'undercurl' },
                },
            },
            dap = {
                enabled = true,
                enable_ui = true,
            },
            navic = {
                enabled = true,
                custom_bg = 'NONE',
            },
            neotree = {
                enabled = true,
                show_root = true,
                transparent_panel = true,
            },
            which_key = true,
            lightspeed = true,
        },
    }

    vim.cmd [[colorscheme catppuccin]]
end

return M
