local M = {}

local function config_req(name)
    return load('require(' .. vim.inspect(name) .. ')')
end

local function config_mod(name, opt, fn)
    return load('require(' .. vim.inspect(name) .. ').' .. (fn or 'setup') .. '(' .. vim.inspect(opt) .. ')')
end

function M.setup()
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
        use { 'lewis6991/gitsigns.nvim', config = config_req 'plugins.config.gitsigns' }
        use {
            'sindrets/diffview.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = config_mod('diffview', {}),
        }

        -- Note taking
        use {
            'nvim-orgmode/orgmode',
            config = config_mod('orgmode', {
                org_agenda_files = { '/Volumes/GoogleDrive/My Drive/orgs/**/*' },
                org_default_notes_file = '/Volumes/GoogleDrive/My Drive/orgs/refile.org',
            }),
        }

        -- Monkey-patches
        use 'antoinemadec/FixCursorHold.nvim' -- https://github.com/neovim/neovim/issues/12587
        use { 'captbaritone/better-indent-support-for-php-with-html', ft = 'php' }

        -- Look & Feel
        use 'folke/tokyonight.nvim'
        use { 'stevearc/dressing.nvim', config = config_mod('dressing', {}) }
        use {
            'https://gitlab.com/yorickpeterse/nvim-pqf.git',
            config = config_mod('pqf', {
                signs = {
                    error = '',
                    warning = '',
                    hint = '',
                    info = '',
                },
            }),
        }
        use 'vimpostor/vim-tpipeline'
        use {
            'nvim-lualine/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = config_mod 'plugins.config.lualine',
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
            config = config_req 'plugins.config.toggleterm',
        }

        -- Navigation
        use 'thinca/vim-visualstar'
        use 'simrat39/symbols-outline.nvim'
        use { 'max397574/better-escape.nvim', config = config_mod 'better_escape' }
        use {
            'kevinhwang91/nvim-ufo',
            requires = 'kevinhwang91/promise-async',
            config = config_mod 'ufo',
        }
        use 'nathom/tmux.nvim'
        use { 'ethanholz/nvim-lastplace', config = config_mod('nvim-lastplace', {}) }
        use {
            'karb94/neoscroll.nvim',
            event = 'BufRead',
            config = config_req 'plugins.config.neoscroll',
        }
        use {
            'nvim-neo-tree/neo-tree.nvim',
            branch = 'v2.x',
            requires = {
                'nvim-lua/plenary.nvim',
                'kyazdani42/nvim-web-devicons',
                'MunifTanjim/nui.nvim',
            },
            config = config_req 'plugins.config.neotree',
        }
        use {
            'akinsho/bufferline.nvim',
            tag = 'v2.*',
            requires = 'kyazdani42/nvim-web-devicons',
            config = config_req 'plugins.config.bufferline',
        }
        use { 'folke/which-key.nvim', config = config_req 'plugins.config.which-key' }
        use {
            'ibhagwan/fzf-lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = config_req 'plugins.config.fzf',
        }
        use {
            'ghillb/cybu.nvim',
            branch = 'v1.x',
            requires = 'kyazdani42/nvim-web-devicons',
            config = config_req 'plugins.config.cybu',
        }
        use { 'chentoast/marks.nvim', config = config_mod('marks', {}) }

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
        use { 'j-hui/fidget.nvim', config = config_mod('fidget', { text = { spinner = 'dots_snake' } }) }
        use { 'turbio/bracey.vim', run = 'npm install --prefix server' }
        use { 'windwp/nvim-autopairs', config = config_mod('nvim-autopairs', {}) }
        use {
            'L3MON4D3/LuaSnip',
            config = config_mod('luasnip.loaders.from_vscode', { paths = { './snippets' } }, 'lazy_load'),
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
            config = config_req 'plugins.config.nvim-cmp',
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
        }
        use { 'smjonas/inc-rename.nvim', config = config_mod 'inc_rename' }
        use 'rafamadriz/friendly-snippets'
        use { 'lewis6991/spellsitter.nvim', config = config_mod 'spellsitter' }
        use 'andymass/vim-matchup'
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'p00f/nvim-ts-rainbow',
                'windwp/nvim-ts-autotag',
                'nvim-treesitter/nvim-treesitter-textobjects',
                {
                    'nvim-treesitter/nvim-treesitter-context',
                    config = config_mod('treesitter-context', {}),
                },
            },
            run = ':TSUpdate',
            config = config_req 'plugins.config.treesitter',
        }
        use {
            'danymat/neogen',
            requires = 'nvim-treesitter/nvim-treesitter',
            config = config_mod('neogen', { snippet_engine = 'luasnip' }),
        }
        use { 'numToStr/Comment.nvim', config = config_mod('Comment', {}) }
        use { 'ray-x/lsp_signature.nvim', config = config_mod('lsp_signature', { hint_enable = false }) }
        use { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    end)
end

return M
