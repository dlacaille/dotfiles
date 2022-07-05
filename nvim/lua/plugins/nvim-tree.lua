require('nvim-tree').setup {
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    create_in_closed_folder = true,
    git = {
        ignore = false,
    },
    view = {
        adaptive_size = true,
        number = true,
        relativenumber = true,
        mappings = {
            -- Uncomment this to enable vinegar-style functionnality
            -- list = {
            --     { key = '<CR>', action = 'edit_in_place' },
            --     -- NOTE: override the "split" to avoid treating nvim-tree
            --     -- window as special. Splits will appear as if nvim-tree was a
            --     -- regular window
            --     {
            --         key = '<C-v>',
            --         action = 'split_right',
            --         action_cb = function(node)
            --             vim.cmd('vsplit ' .. vim.fn.fnameescape(node.absolute_path))
            --         end,
            --     },
            --     {
            --         key = '<C-x>',
            --         action = 'split_bottom',
            --         action_cb = function(node)
            --             vim.cmd('split ' .. vim.fn.fnameescape(node.absolute_path))
            --         end,
            --     },
            --     -- NOTE: override the "open in new tab" mapping to fix the error
            --     -- that occurs there
            --     {
            --         key = '<C-t>',
            --         action = 'new_tab',
            --         action_cb = function(node)
            --             vim.cmd('tabnew ' .. vim.fn.fnameescape(node.absolute_path))
            --         end,
            --     },
            -- },
        },
    },
    renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = 'all',
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,
            },
            glyphs = {
                default = '',
                symlink = '',
                git = {
                    unstaged = '✗',
                    staged = '✓',
                    unmerged = '',
                    renamed = '➜',
                    untracked = '★',
                    deleted = '',
                    ignored = '◌',
                },
                folder = {
                    arrow_open = '',
                    arrow_closed = '',
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                    symlink_open = '',
                },
            },
        },
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
        change_dir = {
            -- NOTE: netrw-style, do not change the cwd when navigating
            enable = false,
        },
    },
}

-- vim.api.nvim_create_user_command('NvimTreeToggleReplace', function()
--     local api = vim.api
--     local view = require 'nvim-tree.view'
--     local core = require 'nvim-tree.core'
--     if view.is_visible() then
--         view.close()
--     elseif vim.bo.filetype == '' then
--         -- open_replacing_current_buffer can't replace empty buffers
--         vim.cmd ':e .'
--     else
--         if view.is_visible() then
--             return
--         end
--
--         local buf = api.nvim_get_current_buf()
--         local bufname = api.nvim_buf_get_name(buf)
--         if bufname == '' or vim.loop.fs_stat(bufname) == nil then
--             return
--         end
--
--         local cwd = vim.fn.getcwd()
--         if not core.get_explorer() or cwd ~= core.get_cwd() then
--             core.init(cwd)
--         end
--         view.open_in_current_win { hijack_current_buf = false, resize = false }
--         require('nvim-tree.renderer').draw()
--         require('nvim-tree.actions.find-file').fn(bufname)
--     end
-- end, {})
