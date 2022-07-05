return require('packer').startup(function(use)
    -- Start time optimization
    use 'lewis6991/impatient.nvim'

    -- Packer
    use 'wbthomason/packer.nvim'

    -- Tim Pope's Greatest Hits
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rsi'

    -- Multi cursors
    use 'mg979/vim-visual-multi'

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require 'plugins.gitsigns'
        end,
    }
    use {
        'sindrets/diffview.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('diffview').setup {}
        end,
    }

    -- Monkey-patches
    use 'antoinemadec/FixCursorHold.nvim' -- https://github.com/neovim/neovim/issues/12587
    use {
        'captbaritone/better-indent-support-for-php-with-html',
        ft = 'php',
    }

    -- Look & Feel
    use 'folke/tokyonight.nvim'
    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {}
        end,
    }
    use {
        'https://gitlab.com/yorickpeterse/nvim-pqf.git',
        config = function()
            require('pqf').setup {
                signs = {
                    error = '',
                    warning = '',
                    hint = '',
                    info = '',
                },
            }
        end,
    }
    use 'vimpostor/vim-tpipeline'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('plugins.lualine').setup()
        end,
    }
    use {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require 'notify'
        end,
    }
    use { 'RRethy/vim-hexokinase', run = 'make hexokinase' }

    -- Terminal
    use {
        'akinsho/toggleterm.nvim',
        tag = 'v1.*',
        config = function()
            require 'plugins.toggleterm'
        end,
    }

    -- Navigation
    use 'thinca/vim-visualstar'
    use 'simrat39/symbols-outline.nvim'
    use {
        'max397574/better-escape.nvim',
        config = function()
            require('better_escape').setup()
        end,
    }
    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = function()
            require('ufo').setup()
        end,
    }
    use 'nathom/tmux.nvim'
    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup {}
        end,
    }
    use {
        'karb94/neoscroll.nvim',
        event = 'BufRead',
        config = function()
            require 'plugins.neoscroll'
        end,
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'plugins.nvim-tree'
        end,
    }
    -- use {
    --     'akinsho/bufferline.nvim',
    --     tag = 'v2.*',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require 'plugins.bufferline'
    --     end,
    -- }
    use {
        'folke/which-key.nvim',
        config = function()
            require 'plugins.which-key'
        end,
    }
    use {
        'ibhagwan/fzf-lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'plugins.fzf'
        end,
    }
    use {
        'ghillb/cybu.nvim',
        branch = 'v1.x',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'plugins.cybu'
        end,
    }
    use {
        'chentoast/marks.nvim',
        config = function()
            require('marks').setup {}
        end,
    }

    -- Markdown
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    }

    -- Language
    use 'RRethy/vim-illuminate'
    use 'cakebaker/scss-syntax.vim'
    use 'MaxMEllon/vim-jsx-pretty'
    use {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup {
                text = {
                    spinner = 'dots_snake',
                },
            }
        end,
    }
    use { 'turbio/bracey.vim', run = 'npm install --prefix server' }
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end,
    }
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets' } }
        end,
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            require 'plugins.nvim-cmp'
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/nvim-lsp-installer',
            'lukas-reineke/lsp-format.nvim',
            'b0o/schemastore.nvim',
            'folke/lua-dev.nvim',
            'hrsh7th/nvim-cmp',
        },
        config = function()
            require 'plugins.lsp'
        end,
    }
    use {
        'smjonas/inc-rename.nvim',
        config = function()
            require('inc_rename').setup()
        end,
    }
    use 'rafamadriz/friendly-snippets'
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end,
    }
    use 'andymass/vim-matchup'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'plugins.treesitter'
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup {}
        end,
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'p00f/nvim-ts-rainbow'
    use 'windwp/nvim-ts-autotag'
    use {
        'danymat/neogen',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('neogen').setup { snippet_engine = 'luasnip' }
        end,
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {}
        end,
    }
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup {
                hint_enable = false,
            }
        end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }
    use {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    }
end)
