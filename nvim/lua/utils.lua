local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = { remap = false }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function M.has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function M.is_empty(s)
    return s == nil or s == ''
end

function M.table_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                M.merge_tables(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

return M
