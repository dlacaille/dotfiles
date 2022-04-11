-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.transparent_window = true
vim.opt.showtabline = 2 -- Always show tab line
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4 -- The number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert 2 spaces for a tab

-- Hide ^M on mixed unix/dos line ending files
vim.cmd "match Ignore /\r$/"

-- Keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Custom mappings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Homerow navigation
lvim.keys.normal_mode["<C-h>"] = "^"
lvim.keys.normal_mode["<C-l>"] = "$"
lvim.keys.normal_mode["<C-j>"] = "jjjj"
lvim.keys.normal_mode["<C-k>"] = "kkkk"

-- Natural editing in insert mode
lvim.keys.insert_mode["<M-bs>"] = {"<cmd>:norm db<cr>", {silent = true}}
lvim.keys.insert_mode["<M-del>"] = {"<cmd>:norm dw<cr>", {silent = true}}
lvim.keys.insert_mode["<M-left>"] = {"<cmd>:norm bi<cr>", {silent = true}}
lvim.keys.insert_mode["<M-right>"] = {"<cmd>:norm w<cr>", {silent = true}}

-- Autocommands
lvim.autocommands.custom_groups = {
    -- On entering insert mode in any file, change fileformat
    {"InsertEnter", "*", ":set ff=unix"}
}

-- NPM scripts
lvim.builtin.which_key.mappings["n"] = {
    name = "NPM",
    i = {
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd = 'npm install', count = 201, direction = 'float'})<cr>",
        "Install packages"
    },
    rw = {
        "<cmd>lua require('lvim.core.terminal')._exec_toggle({cmd = 'npm run watch', count = 202, direction = 'float'})<cr>",
        "Run watch"
    }
}

-- Activate some default plugins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- Configure greeter
lvim.builtin.alpha.dashboard.section.header.val = {
    [[                                                                                ]],
    [[                                                                                ]],
    [[                                                                                ]],
    [[                                                                ⣤⣴⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣦⣄  ]],
    [[ ⢀⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡶                              ⣀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣄⣀   ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆ ]],
    [[ ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇                             ⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄  ⢸⣿⣿⣿       ⢸⣿⣿⣿⡇ ]],
    [[ ⢸⣿⣿⣿⣧⣤⣤⣤⣤⣤⣤⣤⣤⣤⣀    ⣀⣀⣀⡀    ⢀⣀⣀⣀     ⣀⣀⣀⡀    ⢸⣿⣿⣿⠉⠉⠉⠉⠉⠉⠉⠉⣿⣿⣿⡇  ⢸⣿⣿⣿       ⢸⣿⣿⣿⡇ ]],
    [[ ⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ⣿⣿⣿⡇    ⢸⣿⣿⣿     ⣿⣿⣿⡇    ⢸⣿⣿⣿        ⣿⣿⣿⡇  ⢸⣿⣿⣿       ⢸⣿⣿⣿⡇ ]],
    [[ ⢀⣀⣉⣉⣉⣉⣉⣉⣉⣉⣉⣹⣿⣿⣿    ⣿⣿ Agence Numérique - https://swoo.ca ⣿⣿⡇  ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇ ]],
    [[ ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ⣿⣿⣿⡇    ⢸⣿⣿⣿     ⣿⣿⣿⡇    ⢸⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⣿⡇   ⠛⠻⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠛⠋  ]],
    [[ ⠘⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠁    ⣿⣿⣿⡇    ⢸⣿⣿⣿     ⣿⣿⣿⡇    ⠈⠻⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠟                    ]],
    [[                    ⣿⣿⣿⣧⣤⣤⣤⣤⣼⣿⣿⣿⣤⣤⣤⣤⣤⣿⣿⣿⡇                                       ]],
    [[                    ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠇                                       ]],
    [[                                                                                ]],
    [[                                                                                ]]
}

-- Configure nvimtree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.disable_netrw = 0
lvim.builtin.nvimtree.setup.hijack_netrw = 0

-- Taste the rainbow
require("nvim-treesitter.configs").setup {
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil -- Do not enable for files with more than n lines, int
    }
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
    "css", "scss", "rust", "java", "yaml", "vue", "php"
}

-- Configure Treesitter
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.enable = false

-- Display git blame for the current line
lvim.builtin.gitsigns.opts.current_line_blame = true

-- Set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        exe = "phpcsfixer",
        args = {"--config", "/Users/swoo/.swoo-workspace/.php-cs-fixer.php"}
    }, {exe = "prettier", args = {"--tab-width", "4", "--single-quote"}},
    {exe = "lua-format"}
}

-- Set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {{exe = "eslint_d"}}

-- Additional Plugins
lvim.plugins = {
    {"cakebaker/scss-syntax.vim"}, {
        "olimorris/onedarkpro.nvim",
        config = function()
            local onedarkpro = require("onedarkpro")
            onedarkpro.setup({
                colors = {bg = "#131419"}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
                options = {
                    undercurl = true, -- Use the themes opinionated undercurl styles?
                    cursorline = true, -- Use cursorline highlighting?
                    transparency = true, -- Use a transparent background?
                    terminal_colors = true -- Use the theme's colors for Neovim's :terminal?
                },
                styles = {comments = "italic", keywords = "italic"}
            })
            onedarkpro.load()
            lvim.colorscheme = "onedarkpro"
        end
    }, {"tpope/vim-surround"}, {"p00f/nvim-ts-rainbow"},
    {"mg979/vim-visual-multi"}, {"jeffkreeftmeijer/vim-numbertoggle"}, {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({"*"}, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn,
                mode = "background"
            })
        end
    }, {
        "gelguy/wilder.nvim",
        config = function()
            local wilder = require('wilder')
            wilder.setup({modes = {':', '/', '?'}})
            wilder.set_option('renderer', wilder.popupmenu_renderer({
                highlighter = wilder.basic_highlighter(),
                highlights = {
                    accent = wilder.make_hl('WilderAccent', 'Pmenu', {
                        {a = 1}, {a = 1}, {foreground = '#ca62f8'}
                    })
                },
                left = {' ', wilder.popupmenu_devicons()},
                right = {' ', wilder.popupmenu_scrollbar()}
            }))

        end
    }, {"felipec/vim-sanegx"}, {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {show_current_context = true}
        end
    }, {"captbaritone/better-indent-support-for-php-with-html", ff = "php"}
}

-- Configure indent-blankline
vim.g.indent_blankline_filetype_exclude = {
    'alpha', 'terminal', 'lspinfo', 'checkhealth', 'help'
}
