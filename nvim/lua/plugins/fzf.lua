require('fzf-lua').setup {
    winopts = {
        split = 'botright new',
        border = false,
        preview = {
            default = 'bat',
            border = 'noborder',
            delay = 80,
        },
    },
    fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to '' for a non-value flag
        -- for raw args use `fzf_args` instead
        ['--ansi'] = '',
        ['--prompt'] = '> ',
        ['--info'] = 'inline',
        ['--height'] = '100%',
        ['--layout'] = false, -- 'reverse',
        ['--border'] = 'none',
    },
    fzf_colors = {
        ['fg'] = { 'fg', 'CursorLine' },
        ['bg'] = { 'bg', 'Normal' },
        ['hl'] = { 'fg', 'Comment' },
        ['fg+'] = { 'fg', 'Normal' },
        ['bg+'] = { 'bg', 'CursorLine' },
        ['hl+'] = { 'fg', 'Statement' },
        ['info'] = { 'fg', 'PreProc' },
        ['prompt'] = { 'fg', 'Conditional' },
        ['pointer'] = { 'fg', 'Exception' },
        ['marker'] = { 'fg', 'Keyword' },
        ['spinner'] = { 'fg', 'Label' },
        ['header'] = { 'fg', 'Comment' },
        ['gutter'] = { 'bg', 'Normal' },
    },
    on_create = function()
        -- Close nvim-tree if fzf is open, or else the buffer will open beside nvim-tree
        -- "Split windows and the project drawer go together like oil and vinegar" -Drew Neil
        local view = require 'nvim-tree.view'
        if view.is_visible() then
            view.close()
        end
    end,
    previewers = {
        builtin = {
            extensions = {
                ['png'] = { 'tiv' },
                ['jpg'] = { 'tiv' },
            },
        },
    },
    oldfiles = {
        cwd_only = true,
    },
}
