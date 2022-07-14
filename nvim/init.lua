local _, impatient = pcall(require, 'impatient')

require 'config'

require('disabled').setup()
require('plugins').setup()
require('keymaps').setup()
require('autocmds').setup()
require('theme').setup()
require('highlights').setup()
require('lsp').setup()
