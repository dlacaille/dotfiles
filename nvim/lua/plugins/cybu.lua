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
    display_time = 1000,
}
vim.keymap.set('n', 'K', '<Plug>(CybuLastusedPrev)')
vim.keymap.set('n', 'J', '<Plug>(CybuLastusedNext)')
vim.keymap.set('n', 'H', '<Plug>(CybuPrev)')
vim.keymap.set('n', 'L', '<Plug>(CybuNext)')
