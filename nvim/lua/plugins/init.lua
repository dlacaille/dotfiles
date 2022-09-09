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
            'phaazon/mind.nvim',
            branch = 'v2',
            requires = { 'nvim-lua/plenary.nvim' },
            config = config_req 'plugins.config.mind',
        }

        -- Monkey-patches
        use 'antoinemadec/FixCursorHold.nvim' -- https://github.com/neovim/neovim/issues/12587
        use { 'captbaritone/better-indent-support-for-php-with-html', ft = 'php' }

        -- Look & Feel
        use 'folke/tokyonight.nvim'
        use { 'catppuccin/nvim', as = 'catppuccin' }
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
        use {
            'nvim-lualine/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = config_mod 'plugins.config.lualine',
        }
        -- use { 'RRethy/vim-hexokinase', run = 'make hexokinase' }
        use {
            'mrshmllow/document-color.nvim',
            config = config_mod('document-color', {}),
        }

        -- Terminal
        use {
            'akinsho/toggleterm.nvim',
            config = config_req 'plugins.config.toggleterm',
        }

        -- Navigation
        use 'simrat39/symbols-outline.nvim'
        use 'nathom/tmux.nvim'
        use { 'ethanholz/nvim-lastplace', config = config_mod('nvim-lastplace', {}) }
        use {
            'karb94/neoscroll.nvim',
            event = 'BufRead',
            config = config_req 'plugins.config.neoscroll',
        }
        use {
            'petertriho/nvim-scrollbar',
            config = config_mod 'scrollbar',
        }
        use {
            'SmiteshP/nvim-navic',
            requires = 'neovim/nvim-lspconfig',
            config = config_req 'plugins.config.navic',
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
        use { 'folke/which-key.nvim', config = config_req 'plugins.config.which-key' }
        use {
            'ibhagwan/fzf-lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = config_req 'plugins.config.fzf',
        }
        use { 'chentoast/marks.nvim', config = config_mod('marks', {}) }

        -- Language
        use 'cakebaker/scss-syntax.vim'
        use 'jxnblk/vim-mdx-js'
        use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm i' }
        use { 'gaoDean/autolist.nvim', config = config_mod('autolist', {}) }
        use { 'napmn/react-extract.nvim', config = config_req 'plugins.config.react-extract' }
        use { 'mfussenegger/nvim-dap', config = config_req 'plugins.config.dap' }
        use { 'rcarriga/nvim-dap-ui', config = config_mod('dapui', {}) }
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
                'David-Kunz/cmp-npm',
                'saadparwaiz1/cmp_luasnip',
            },
            config = config_req 'plugins.config.nvim-cmp',
        }
        use {
            'windwp/nvim-autopairs',
            config = config_mod('nvim-autopairs', {
                enable_check_bracket_line = false,
            }),
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
        use 'rafamadriz/friendly-snippets'
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                'p00f/nvim-ts-rainbow',
                'windwp/nvim-ts-autotag',
                'RRethy/nvim-treesitter-endwise',
                'nvim-treesitter/nvim-treesitter-textobjects',
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
