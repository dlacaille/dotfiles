-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarkpro"
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4 -- The number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert 2 spaces for a tab
vim.opt.titlestring = "%{split(getcwd(), '/')[-1]} - %t"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 20
vim.cmd("set diffopt+=hiddenoff,iwhiteall,algorithm:patience")

-- Hide ^M on mixed unix/dos line ending files
vim.cmd "match Ignore /\r$/"

-- Keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Custom mappings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Quick wins
lvim.keys.normal_mode[",,"] = "A,<esc>"
lvim.keys.normal_mode[",o"] = "A,<esc>o"
lvim.keys.normal_mode[";;"] = "A;<esc>"
lvim.keys.normal_mode[";o"] = "A;<esc>o"

-- Natural editing in insert mode
lvim.keys.insert_mode["<M-bs>"] = {"<cmd>:norm db<cr>", {silent = true}}
lvim.keys.insert_mode["<M-del>"] = {"<cmd>:norm dw<cr>", {silent = true}}
lvim.keys.insert_mode["<M-left>"] = {"<cmd>:norm bi<cr>", {silent = true}}
lvim.keys.insert_mode["<M-right>"] = {"<cmd>:norm w<cr>", {silent = true}}

-- Terminal config
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.size = 15
lvim.builtin.terminal.shade_terminals = false

-- Git mappings
lvim.builtin.which_key.mappings["g"]["h"] = {
    "<cmd>:DiffviewFileHistory<cr>", "File History"
}

-- Symbols outline
lvim.builtin.which_key.mappings["o"] = {
    "<cmd>:SymbolsOutline<cr>", "Symbols Outline"
}

-- Activate some default plugins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- Configure greeter
lvim.builtin.alpha.dashboard.section.header.val = {
    [[                                                                                ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⠀⠀]],
    [[⠀⢸⣿⣿⣿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠁⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⡿⠿⠿⠿⠿⠿⠿⠿⣿⣿⣿⡇⠀⠀⠀⢸⣿⣿⣿⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⠀⠀]],
    [[⠀⢸⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣄⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡇⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀]],
    [[⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿ Agence Numérique - https://swoo.ca ⣿⡇⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀]],
    [[⠀⢠⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣼⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⣤⣤⣤⣤⣼⣿⣿⣿⣤⣤⣤⣤⣤⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣧⣤⣤⣤⣤⣤⣤⣤⣿⣿⣿⡇⠀⠀⠀⢸⣿⣿⣿⣤⣤⣤⣤⣤⣤⣤⣼⣿⣿⣿⠀⠀]],
    [[⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀]],
    [[⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀]],
    [[                                                                                ]]
}

-- Configure nvimtree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.disable_netrw = 0
lvim.builtin.nvimtree.setup.hijack_netrw = 0

-- Add ignores to telescope
lvim.builtin.telescope.defaults.file_ignore_patterns = {
    "vendor/*", "dist/*", "%.lock", "__pycache__/*", "%.sqlite3", "%.ipynb",
    "node_modules/*", "%.jpg", "%.jpeg", "%.png", "%.svg", "%.otf", "%.ttf",
    ".git/", "%.webp", ".dart_tool/", ".github/", ".gradle/", ".idea/",
    ".settings/", ".vscode/", "__pycache__/", "build/", "env/", "gradle/",
    "node_modules/", "target/", "%.pdb", "%.dll", "%.class", "%.exe", "%.cache",
    "%.ico", "%.pdf", "%.dylib", "%.jar", "%.docx", "%.met", "smalljre_*/*",
    ".vale/", "package-lock.json", "%.map", "public/*"
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
    }, {command = "prettierd"}, {exe = "lua-format"}
}

-- Set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {{exe = "eslint_d"}}

-- Additional Plugins
lvim.plugins = {}
function use(plugin) table.insert(lvim.plugins, plugin) end

-- Colorschemes
use {"lunarvim/colorschemes"}
use {"folke/tokyonight.nvim"}
use {"olimorris/onedarkpro.nvim"}
use {"luxed/ayu-vim"}

-- Configure theme
local onedarkpro = require("onedarkpro")
onedarkpro.setup({
    colors = {bg = "#131419"}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
    options = {
        undercurl = true, -- Use the themes opinionated undercurl styles?
        cursorline = true -- Use cursorline highlighting?
    },
    styles = {comments = "italic", keywords = "italic"}
})
onedarkpro.load()

-- Fixes the syntax for scss files
use {"cakebaker/scss-syntax.vim"}

-- Necessities
use {"tpope/vim-surround"}
use {"jeffkreeftmeijer/vim-numbertoggle"}

-- 🐙 Octo
use {"pwntester/octo.nvim", config = function() require"octo".setup() end}

-- Shows diff view in a tab
use {"sindrets/diffview.nvim"}

-- Symbols outline for code
use {"simrat39/symbols-outline.nvim"}

-- Highlight colors
use {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            "css", "scss", "javascript", "typescript", "vue", "php", "html",
            "lua", "vim"
        }, {
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
}

-- Better quickfix window
use {
    "kevinhwang91/nvim-bqf",
    event = {"BufRead", "BufNew"},
    config = function()
        require("bqf").setup({
            auto_enable = true,
            preview = {
                win_height = 12,
                win_vheight = 12,
                delay_syntax = 80,
                border_chars = {
                    "┃", "┃", "━", "━", "┏", "┓", "┗", "┛",
                    "█"
                }
            },
            func_map = {vsplit = "", ptogglemode = "z,", stoggleup = ""},
            filter = {
                fzf = {
                    action_for = {["ctrl-s"] = "split"},
                    extra_opts = {
                        "--bind", "ctrl-o:toggle-all", "--prompt", "> "
                    }
                }
            }
        })
    end
}

-- Let's fly
use {"ggandor/lightspeed.nvim", event = "BufRead"}

-- Smooth sailing
use {
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
        require('neoscroll').setup()

        local t = {}
        -- Syntax: t[keys] = {function, {function arguments}}
        t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}}
        t['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '150'}}
        t['<C-b>'] = {
            'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '150'}
        }
        t['<C-f>'] = {
            'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '150'}
        }
        t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
        t['<C-e>'] = {'scroll', {'0.10', 'false', '100'}}
        t['zt'] = {'zt', {'150'}}
        t['zz'] = {'zz', {'150'}}
        t['zb'] = {'zb', {'150'}}

        require('neoscroll.config').set_mappings(t)
    end
}

-- HTML Tag magic
use {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function() require("nvim-ts-autotag").setup() end
}

-- Taste the rainbow
use {
    "p00f/nvim-ts-rainbow",
    config = function()
        require("nvim-treesitter.configs").setup {
            rainbow = {
                enable = true,
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil -- Do not enable for files with more than n lines, int
            }
        }
    end
}

-- Better command palette
use {
    "gelguy/wilder.nvim",
    config = function()
        local wilder = require('wilder')
        wilder.setup({modes = {':', '/', '?'}})
        local opts = {
            highlighter = wilder.basic_highlighter(),
            highlights = {
                accent = wilder.make_hl('WilderAccent', 'Pmenu', {
                    {a = 1}, {a = 1}, {foreground = '#ca62f8'}
                })
            },
            left = {' ', wilder.popupmenu_devicons()},
            right = {' ', wilder.popupmenu_scrollbar()}
        }
        wilder.set_option('renderer', wilder.popupmenu_renderer(opts))
    end
}

-- Show lines for indents
use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("indent_blankline").setup {show_current_context = true}
        vim.g.indent_blankline_filetype_exclude = {
            'alpha', 'terminal', 'lspinfo', 'checkhealth', 'help'
        }
    end
}

-- Fix broken html syntax in php
use {"captbaritone/better-indent-support-for-php-with-html", ff = "php"}
