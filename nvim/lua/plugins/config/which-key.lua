local whichkey = require 'which-key'

local conf = {
    plugins = {
        spelling = {
            enabled = true,
        },
    },
    window = {
        border = 'none', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 1, 0, 1 },
        winblend = 25,
    },
}

local mappings = {
    visual_leader = {
        ['é'] = { "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", 'Comment' },
    },
    normal_leader = {
        -- Basics
        w = { '<cmd>w!<cr>', 'Save' },
        q = { '<cmd>q!<cr>', 'Quit' },
        ['é'] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", 'Comment' },

        -- Explorer
        e = { '<cmd>Neotree reveal<cr>', 'Explorer' },

        -- Symbols
        s = { '<cmd>SymbolsOutline<cr>', 'Symbols' },

        -- Org mode
        o = 'Org mode',

        -- Buffers
        c = { '<cmd>%bd|e#|bd#<cr>', 'Close all but current' },
        C = { '<cmd>bufdo bwipeout<cr>', 'Close all buffers' },

        -- FZF
        b = { "<cmd>lua require('fzf-lua').buffers()<cr>", 'Buffers' },
        f = { "<cmd>lua require('fzf-lua').files()<cr>", 'Files' },
        h = { "<cmd>lua require('fzf-lua').oldfiles()<cr>", 'History' },
        r = { "<cmd>lua require('fzf-lua').live_grep_glob()<cr>", 'Ripgrep' },
        ['"'] = { "<cmd>lua require('fzf-lua').registers()<cr>", 'Registers' },

        -- Git
        g = {
            name = 'Git',
            g = { '<cmd>lua _lazygit_toggle()<cr>', 'Lazygit' },
            c = { '<cmd>Git mergetool<cr>', 'Conflicts' },
            d = { '<cmd>DiffviewOpen<cr>', 'Diffview' },
        },

        -- LSP
        l = {
            name = 'LSP',
            d = { vim.lsp.buf.type_definition, 'Type definition' },
            e = { vim.diagnostic.open_float, 'Diagnostics' },
            q = { vim.diagnostic.setloclist, 'Quickfix' },
            i = { '<cmd>LspInfo<cr>', 'Info' },
            n = { '<cmd>NullLsInfo<cr>', 'Null-ls Info' },
            I = { '<cmd>LspInstallInfo<cr>', 'Install' },
            f = { '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', 'Format' },
            r = {
                function()
                    vim.fn.feedkeys(':IncRename ' .. vim.fn.expand '<cword>', 'n')
                end,
                'Rename',
            },
        },

        -- Packer
        p = {
            name = 'Packer',
            c = { '<cmd>PackerCompile<cr>', 'Compile' },
            i = { '<cmd>PackerInstall<cr>', 'Install' },
            s = { '<cmd>PackerSync<cr>', 'Sync' },
            S = { '<cmd>PackerStatus<cr>', 'Status' },
            u = { '<cmd>PackerUpdate<cr>', 'Update' },
        },
    },
    normal = {
        -- Go to
        ['gD'] = { vim.lsp.buf.declaration, 'Go to declaration' },
        ['gd'] = { vim.lsp.buf.definition, 'Go to definition' },
        ['gi'] = { vim.lsp.buf.implementation, 'Go to implementation' },
        ['gr'] = { vim.lsp.buf.references, 'Go to references' },

        -- Quickfix navigation
        [']q'] = { '<cmd>cnext<cr>', 'Next quickfix entry' },
        ['[q'] = { '<cmd>cnext<cr>', 'Previous quickfix entry' },
    },
}

whichkey.setup(conf)
whichkey.register(mappings.visual_leader, { prefix = '<leader>', mode = 'x' })
whichkey.register(mappings.normal_leader, { prefix = '<leader>' })
whichkey.register(mappings.normal)
