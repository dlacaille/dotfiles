local whichkey = require 'which-key'

local conf = {
    plugins = {
        spelling = {
            enabled = true,
        },
    },
    window = {
        border = 'single', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
    },
}

local mappings = {
    visual_leader = {
        ['é'] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", 'Comment' },

        -- React
        r = {
            name = 'React',
            e = { require('react-extract').extract_to_new_file, 'Extract to new file' },
            c = { require('react-extract').extract_to_current_file, 'Extract to component' },
        },
    },
    normal_leader = {
        -- Basics
        w = { '<cmd>w!<cr>', 'Save' },
        q = { '<cmd>q!<cr>', 'Quit' },
        ['é'] = { require('Comment.api').toggle.linewise.current, 'Comment' },

        -- Explorer
        e = { '<cmd>Neotree reveal<cr>', 'Explorer' },

        -- Symbols
        s = { '<cmd>SymbolsOutline<cr>', 'Symbols' },

        -- Buffers
        [' '] = { '<cmd>Neotree buffers<cr>', 'Buffers' },

        -- FZF
        f = { "<cmd>lua require('fzf-lua').files()<cr>", 'Files' },
        h = { "<cmd>lua require('fzf-lua').oldfiles()<cr>", 'History' },
        r = { "<cmd>lua require('fzf-lua').live_grep_glob()<cr>", 'Ripgrep' },

        -- Mind
        m = { require('mind').open_main, 'Mind' },

        -- Git
        g = {
            name = 'Git',
            g = { '<cmd>lua _lazygit_toggle()<cr>', 'Lazygit' },
            c = { '<cmd>Git mergetool<cr>', 'Conflicts' },
            d = { '<cmd>DiffviewOpen<cr>', 'Diffview' },
        },

        -- Debug
        d = {
            name = 'Debug',
            u = { require('dapui').toggle, 'Toggle sidebar' },
            b = { require('dap').toggle_breakpoint, 'Toggle breakpoint' },
            B = {
                function()
                    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                end,
                'Conditional breakpoint',
            },
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
