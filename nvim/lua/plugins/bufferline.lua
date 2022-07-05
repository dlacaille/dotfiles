require('bufferline').setup {
    options = {
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        middle_mouse_command = 'bdelete! %d',
        custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= 'fzf' then
                return true
            end
        end,
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'NvimTree',
                highlight = 'BufferInactive',
                padding = 1,
            },
            {
                filetype = 'Outline',
                text = 'Outline',
                highlight = 'BufferInactive',
                padding = 1,
            },
        },
    },
}
