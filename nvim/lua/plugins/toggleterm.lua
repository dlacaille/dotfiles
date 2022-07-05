local toggleterm = require 'toggleterm'
toggleterm.setup()

local Terminal = require('toggleterm.terminal').Terminal

function execute_read(command)
    local handle = io.popen(command)
    if handle then
        local result = handle:read '*a'
        handle:close()
        return result
    end
end

local watch_pane = os.getenv 'WATCH_PANE'
local lazygit = Terminal:new {
    cmd = 'lazygit',
    hidden = true,
    direction = 'float',
    on_open = function()
        if watch_pane then
            os.execute('tmux send-keys -t ' .. watch_pane .. ' C-z')
        end
    end,
    on_close = function()
        if watch_pane then
            os.execute('tmux send-keys -t ' .. watch_pane .. ' fg Enter')
        end
    end,
}

function _lazygit_toggle()
    lazygit:toggle()
end
