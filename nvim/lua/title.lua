local M = {}

M.ignore = { 'term', 'help', 'fzf', 'toggleterm', 'NvimTree' }

function M.setup()
    vim.o.winbar = "%!v:lua.require'title'.render()"
end

function M.setup_buffer() end

function M.icon()
    local icon = require('nvim-web-devicons').get_icon_by_filetype(M.ft())

    if icon then
        return ' ' .. icon
    end

    return ' '
end

function M.bufname()
    local bufname = vim.api.nvim_buf_get_name(M.buf())
    if bufname == nil or string.len(bufname) == 0 then
        return nil
    end
    local rel = string.gsub(bufname, vim.loop.cwd() .. '/', '')
    local last_slash = string.find(rel, '/[^/]*$')
    if not last_slash then
        return '%#BufferActive' .. rel
    end
    return '%#BufferInactive#' .. string.sub(rel, 1, last_slash) .. '%#BufferActive#' .. string.sub(rel, last_slash + 1)
end

function M.has_buffer()
    local name = M.bufname()
    local has_value = require('utils').has_value

    return name ~= nil and not has_value(M.ignore, M.ft())
end

function M.buf()
    local win = vim.g.statusline_winid
    return vim.api.nvim_win_get_buf(win)
end

function M.ft()
    return vim.api.nvim_buf_get_option(M.buf(), 'filetype')
end

function M.bufmodified()
    if vim.fn.getbufvar('%', '&mod') == 1 then
        return '%#BufferVisibleMod#▎'
    end
    return '%#TabLineIndicator#▎'
end

function M.render()
    if not M.has_buffer() then
        return '%#BufferInactive# ' .. M.ft()
    end
    return M.bufmodified() .. M.icon() .. ' ' .. M.bufname()
end

return M
