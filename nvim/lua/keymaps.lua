local M = {}

function M.setup()
    local map = require('utils').map

    -- Navigate between splits
    map('n', '<C-h>', '<cmd>wincmd h<cr>')
    map('n', '<C-j>', '<cmd>wincmd j<cr>')
    map('n', '<C-k>', '<cmd>wincmd k<cr>')
    map('n', '<C-l>', '<cmd>wincmd l<cr>')

    -- Do not replace clipboard contents when pasting over selected text
    map('x', 'p', function()
        return 'pgv"' .. vim.v.register .. 'y'
    end, { expr = true })

    -- Fast scroll in wezterm
    if os.getenv 'TERM' == 'wezterm' then
        local scroll_repeat = 3
        map('n', '<ScrollWheelUp>', string.rep('<ScrollWheelUp>', scroll_repeat))
        map('n', '<ScrollWheelDown>', string.rep('<ScrollWheelDown>', scroll_repeat))
    end

    -- LSP
    map('n', '<C-a>', '<cmd>CodeActionMenu<cr>')

    -- DAP
    map('n', '<F5>', require('dap').continue)
    map('n', '<F6>', require('dap').step_over)
    map('n', '<F7>', require('dap').step_into)
    map('n', '<F8>', require('dap').step_out)

    -- Move lines
    map('n', '<A-j>', ':m .+1<CR>==')
    map('n', '<A-k>', ':m .-2<CR>==')
    map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
    map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
    map('v', '<A-j>', ":m '>+1<CR>gv=gv")
    map('v', '<A-k>', ":m '<-2<CR>gv=gv")

    -- Text object remaps
    -- d as "
    map('v', 'id', 'i"')
    map('v', 'ad', 'a"')
    map('o', 'id', 'i"')
    map('o', 'ad', 'a"')

    -- s as ' (normally for sentences, not used often when coding)
    map('v', 'is', "i'")
    map('v', 'as', "a'")
    map('o', 'is', "i'")
    map('o', 'as', "a'")

    -- c as {
    map('v', 'ic', 'i{')
    map('v', 'ac', 'a{')
    map('o', 'ic', 'i{')
    map('o', 'ac', 'a{')

    -- French keyboard
    map('n', 'é', '^', { remap = true })
    map('n', 'É', '$', { remap = true })
    map('v', 'é', '^', { remap = true })
    map('v', 'É', '$', { remap = true })

    -- Better indenting
    map('v', '<', '<gv')
    map('v', '>', '>gv')

    -- Natural editing in insert mode
    -- TODO: Fix this not working at end of line
    map('i', '<home>', '<cmd>:norm ^<cr>')
    map('i', '<M-bs>', '<cmd>:norm db<cr>')
    map('i', '<M-del>', '<cmd>:norm dw<cr>')
    map('i', '<M-left>', '<cmd>:norm bi<cr>')
    map('i', '<M-right>', '<cmd>:norm w<cr>')

    -- Kill highlights
    map('n', '<esc>', function()
        -- Hide highlights
        vim.cmd 'noh'
        -- Close all floating windows
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local config = vim.api.nvim_win_get_config(win)
            if config.relative ~= '' then -- is_floating_window?
                vim.api.nvim_win_close(win, true)
            end
        end
    end, { silent = true })

    -- Tmux bindings
    map('n', '<C-h>', "<cmd>lua require('tmux').move_left()<cr>")
    map('n', '<C-l>', "<cmd>lua require('tmux').move_right()<cr>")
    map('n', '<C-k>', "<cmd>lua require('tmux').move_up()<cr>")
    map('n', '<C-j>', "<cmd>lua require('tmux').move_down()<cr>")
end

return M
