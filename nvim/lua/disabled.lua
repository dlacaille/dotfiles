-- Disable some built-in nvim plugins
local disabled_plugins = {
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

for _, p in pairs(disabled_plugins) do
    vim.g['loaded_' .. p] = true
end
