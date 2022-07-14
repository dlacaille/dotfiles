local colors = require 'colors'

require('orgmode').setup_ts_grammar()

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'javascript',
        'json',
        'lua',
        'python',
        'typescript',
        'tsx',
        'org',
        'css',
        'scss',
        'rust',
        'java',
        'yaml',
        'vue',
        'php',
        'html',
        'fish',
    },
    sync_install = false,

    highlight = {
        enable = true,
        disable = { 'php', 'html' },
        additional_vim_regex_highlighting = true,
    },

    indent = {
        enable = true,
        disable = { 'php' },
    },

    matchup = {
        enable = true,
    },

    autotag = {
        enable = true,
    },

    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
            },
        },
    },

    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int

        colors = {
            colors.magenta,
            colors.blue,
            colors.blue2,
            colors.teal,
            colors.green,
            colors.orange,
            colors.red,
        },
    },
}
