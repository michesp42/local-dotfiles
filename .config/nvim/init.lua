-- init.lua

require 'early-init'
require 'plugins'
require 'settings'
require 'keymaps'

-- improve startup
require('impatient').enable_profile()

-- can't live without
require 'config.essential.colorscheme'
require 'config.essential.telescope'
require 'config.essential.treesitter'
require 'config.essential.lint'
require 'config.essential.undotree'

-- lsp config
require 'config.lsp.lspconfig'
require 'config.lsp.cmp'
require 'config.lsp.snippets'

-- very helpful plugins
require 'config.helpful.autopairs'
require 'config.helpful.comment'
require 'config.helpful.formatter'
require 'config.helpful.gitsigns'
require 'config.helpful.nvim-highlight-colors'
require 'config.helpful.terminal'
require 'config.helpful.diffview'
require 'config.helpful.writing'
require 'config.helpful.todo-comments'
require 'config.helpful.which-key'

-- looks nice
require 'config.whimsical.devicons'
require 'config.whimsical.statusline'
require 'config.whimsical.nvim-tree'
