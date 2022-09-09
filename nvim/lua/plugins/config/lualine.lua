local M = {}

local lualine = require 'lualine'
local colors = require 'colors'
local navic = require 'nvim-navic'
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
    lsp = {
        function()
            -- ID will be used for caching
            local id = vim.api.nvim_get_current_buf()

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
                if client.name ~= 'null-ls' and client.attached_buffers[id] then
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

            local sourcestr = table.concat(buf_client_names, ', ')
            local component = sourcestr ~= '' and ' ' .. sourcestr or ''

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
    icon = {
        'filetype',
        icon_only = true,
        colored = true,
        padding = { left = 1, right = 0 },
    },
    filename = {
        'filename',
        path = 0,
        color = function(section)
            return { fg = vim.bo.modified and colors.yellow or colors.fg }
        end,
        symbols = {
            modified = ' ●', -- Text to show when the file is modified.
            readonly = '',
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]', -- Text to show for new created file before first writting
        },
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
    dap = {
        function()
            return require('dap').status()
        end,
    },
    navic = {
        navic.get_location,
        cond = navic.is_available,
        color = { fg = colors.fg },
    },
}

M.themes = {}

local linebg = colors.bg
M.themes.custom = {
    normal = {
        a = { bg = colors.blue, fg = colors.black },
        b = { bg = linebg, fg = colors.blue },
        c = { bg = linebg, fg = colors.comment },
    },
    insert = {
        a = { bg = colors.green, fg = colors.black },
        b = { bg = linebg, fg = colors.green },
    },
    command = {
        a = { bg = colors.yellow, fg = colors.black },
        b = { bg = linebg, fg = colors.yellow },
    },
    visual = {
        a = { bg = colors.magenta, fg = colors.black },
        b = { bg = linebg, fg = colors.magenta },
    },
    replace = {
        a = { bg = colors.red, fg = colors.black },
        b = { bg = linebg, fg = colors.red },
    },
    inactive = {
        a = { bg = linebg, fg = colors.blue },
        b = { bg = linebg, fg = colors.fg_gutter, gui = 'bold' },
        c = { bg = linebg, fg = colors.fg_gutter },
    },
}

function M.setup()
    lualine.setup {
        extensions = {
            'neo-tree',
            'nvim-dap-ui',
            'quickfix',
            'symbols-outline',
            'toggleterm',
        },
        disabled_filetypes = {
            tabline = { 'packer', 'neo-tree' },
        },
        options = {
            theme = M.themes.custom,
            always_divide_middle = true,
            section_separators = '',
            component_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'filename' },
            lualine_x = { M.components.filetype },
            lualine_y = { M.components.treesitter, M.components.lsp },
            lualine_z = {},
        },
        inactive_sections = {},
    }
end

return M
