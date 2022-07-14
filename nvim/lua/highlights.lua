local M = {}

function M.setup()
    local colors = require 'colors'
    local hl = vim.api.nvim_set_hl

    -- Highlight matched parentheses
    hl(0, 'MatchParen', { bg = colors.comment })
    hl(0, 'TabLineIndicator', { bg = colors.bg_statusline, fg = colors.blue })
    hl(0, 'MoveHLM', {
        bg = 'NONE',
        fg = colors.blue,
    })

    -- Title bar highlights
    local titlebg = colors.black
    hl(0, 'TitleIconNormal', { fg = colors.blue, bg = titlebg })
    hl(0, 'TitleIconModified', { fg = colors.yellow, bg = titlebg })
    hl(0, 'TitleInactive', { fg = colors.comment, bg = titlebg })
    hl(0, 'TitleActive', { fg = colors.fg, bold = true, bg = titlebg })

    -- Multi cursors highlights
    vim.g.VM_Extend_hl = 'IncSearch'
    vim.g.VM_Cursor_hl = 'Substitute'
    vim.g.VM_Insert_hl = 'DiffAdd'
    vim.g.VM_Mono_hl = 'IncSearch'
end

return M
