local colors = require 'colors'
local hl = vim.highlight.create

-- Highlight matched parentheses
hl('MatchParen', { guibg = colors.comment, gui = 'NONE' })
hl('TabLineIndicator', { guibg = colors.bg_statusline, guifg = colors.blue })
hl('MoveHLM', {
    guibg = 'NONE',
    guifg = colors.blue,
    gui = 'NONE',
})

-- Multi cursors highlights
vim.g.VM_Extend_hl = 'IncSearch'
vim.g.VM_Cursor_hl = 'Substitute'
vim.g.VM_Insert_hl = 'DiffAdd'
vim.g.VM_Mono_hl = 'IncSearch'
