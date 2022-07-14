local M = {}

M.disabled_plugins = {
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'shada_plugin',
    'spellfile_plugin',
    'tutor_mode_plugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'matchit',
    'matchparen',
    'logiPat',
    'rrhelper',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
}

function M.setup()
    for _, p in pairs(M.disabled_plugins) do
        -- Disable some built-in nvim plugins
        vim.g['loaded_' .. p] = true
    end
end

return M
