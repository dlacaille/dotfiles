vim.g.mapleader = ' '
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.g.tpipeline_cursormoved = true
vim.g.cursorhold_updatetime = 100

-- Hexokinase settings
vim.g.Hexokinase_highlighters = { 'backgroundfull' }
vim.g.Hexokinase_optInPatterns = { 'full_hex', 'triple_hex', 'rgb', 'rgba', 'hsl', 'hsla' }

vim.o.termguicolors = true
vim.o.cmdheight = 1
vim.o.shell = '/bin/zsh'
vim.o.undodir = vim.fn.stdpath 'config' .. '/undo'
vim.o.undofile = true
vim.o.mouse = 'a'
vim.o.scrolloff = 6
vim.o.lazyredraw = true
vim.o.laststatus = 3
vim.o.redrawtime = 10000
vim.o.wrap = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.clipboard = 'unnamedplus'
vim.o.timeoutlen = 200
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.number = true
vim.wo.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.wo.foldcolumn = '0'
vim.wo.foldlevel = 99
vim.wo.foldenable = true
