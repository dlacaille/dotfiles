local M = {}

function M.setup()
    vim.g.tokyonight_style = 'night'
    vim.g.tokyonight_day_brightness = 0.3
    vim.g.tokyonight_sidebars = { 'Outline' }
    vim.cmd [[colorscheme tokyonight]]
end

return M
