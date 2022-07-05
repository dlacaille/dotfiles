local M = {}

local lualine = require 'lualine'
local colors = require 'colors'
local window_width_limit = 70

local lsp_cache = {}
function M.clear_cache()
    lsp_cache = {}
end

local gitstatus = require 'gitstatus'
gitstatus.setup {}

M.conditions = {
    hide_in_width = function()
        return vim.fn.winwidth(0) > window_width_limit
    end,
}

M.components = {
    treesitter = {
        function()
            local b = vim.api.nvim_get_current_buf()
            if next(vim.treesitter.highlighter.active[b]) then
                return ''
            end
            return ''
        end,
        color = { fg = colors.green },
        cond = M.conditions.hide_in_width,
    },
    gitstatus = {
        function()
            return gitstatus.render()
        end,
        color = { fg = colors.yellow },
        cond = M.conditions.hide_in_width,
    },
    mode = {
        function()
            return ''
        end,
    },
    lsp = {
        function()
            -- ID will be used for caching
            local id = vim.bo.filetype

            if lsp_cache[id] then
                return lsp_cache[id]
            end

            local buf_clients = vim.lsp.get_active_clients()
            if next(buf_clients) == nil then
                return ''
            end

            local buf_ft = vim.bo.filetype
            local buf_client_names = {}

            for _, client in pairs(buf_clients) do
                if client.name ~= 'null-ls' then
                    table.insert(buf_client_names, client.name)
                end
            end

            local null_ls = require 'null-ls'
            local has_value = require('utils').has_value
            local sources = null_ls.get_sources()
            for _, source in ipairs(sources) do
                if source.filetypes[buf_ft] and not has_value(buf_client_names, source.name) then
                    table.insert(buf_client_names, source.name)
                end
            end

            local component = ' ' .. table.concat(buf_client_names, ', ')
            lsp_cache[id] = component
            return component
        end,
        color = { gui = 'bold' },
        cond = M.conditions.hide_in_width,
    },
    filetype = {
        'filetype',
        colored = false,
    },
    scrollbar = {
        function()
            local current_line = vim.fn.line '.'
            local total_lines = vim.fn.line '$'
            local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
        end,
        padding = { left = 0, right = 0 },
        color = { fg = colors.yellow, bg = colors.bg },
        cond = nil,
    },
}

M.themes = {}

M.themes.tokyonight_custom = {
    normal = {
        a = { bg = colors.blue, fg = colors.black },
        b = { bg = colors.bg, fg = colors.blue },
        c = { bg = colors.bg, fg = colors.comment },
    },
    insert = {
        a = { bg = colors.green, fg = colors.black },
        b = { bg = colors.bg, fg = colors.green },
    },
    command = {
        a = { bg = colors.yellow, fg = colors.black },
        b = { bg = colors.bg, fg = colors.yellow },
    },
    visual = {
        a = { bg = colors.magenta, fg = colors.black },
        b = { bg = colors.bg, fg = colors.magenta },
    },
    replace = {
        a = { bg = colors.red, fg = colors.black },
        b = { bg = colors.bg, fg = colors.red },
    },
    inactive = {
        a = { bg = colors.bg, fg = colors.blue },
        b = { bg = colors.bg, fg = colors.fg_gutter, gui = 'bold' },
        c = { bg = colors.bg, fg = colors.fg_gutter },
    },
}

function M.setup()
    lualine.setup {
        options = {
            theme = M.themes.tokyonight_custom,
            globalstatus = true,
            always_divide_middle = true,
            section_separators = '',
            component_separators = '',
        },
        sections = {
            lualine_a = { M.components.filetype },
            lualine_b = { 'branch', M.components.gitstatus },
            lualine_c = { 'diagnostics', M.components.treesitter },
            lualine_x = { 'location' },
            lualine_y = { M.components.lsp },
            lualine_z = { M.components.scrollbar },
        },
    }
end

return M
