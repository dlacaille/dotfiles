require('cybu').setup {
    behavior = {
        mode = {
            last_used = {
                switch = 'immediate',
                view = 'rolling',
            },
        },
    },
    style = {
        hide_buffer_id = true,
    },
}
vim.keymap.set('n', 'K', '<Plug>(CybuLastusedPrev)')
vim.keymap.set('n', 'J', '<Plug>(CybuLastusedNext)')
