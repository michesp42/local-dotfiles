local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local opt = vim.opt

o.tabstop = 4
o.softtabstop = 4
o.scrolloff = 8
o.sidescrolloff = 8
o.laststatus = 3 -- global statusline
-- o.updatetime = 100
-- o.timeoutlen = 500
-- o.redrawtime = 500

o.expandtab = false
o.autoindent = true
o.smartindent = true
o.wrap = false
o.incsearch = true
o.hidden = true
o.cursorline = true
o.backup = false
o.termguicolors = true
o.ignorecase = true
o.showmode = false
o.list = true
o.hlsearch = false

o.colorcolumn = '80'
-- o.completeopt = 'menu,menuone,noselect,noinsert'
o.diffopt = 'internal,filler,closeoff,algorithm:patience,iwhiteall'
o.mouse = 'a'
o.showbreak = '↪ '
o.background = 'dark'

bo.shiftwidth = 4
bo.swapfile = false

wo.number = true
wo.relativenumber = true
wo.linebreak = true

wo.signcolumn = 'yes'
-- foldmethod = 'expr'
-- foldexpr = 'nvim_treesitter#foldexpr()'

g.wildignore = { '*.git/', '*.tags', '*.o', '*.class', '*.ccls-cache' }
g.mapleader = ' '


-- netrw config
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 0
g.netrw_winsize = 25

-- the following requires set list (?)
-- opt.listchars:append 'eol:↴'
opt.listchars:append 'tab:» '
opt.listchars:append 'trail:·'
opt.listchars:append 'precedes:←'
opt.listchars:append 'extends:→'
opt.listchars:append 'nbsp:·'

opt.shortmess:append({ I = true }) -- inhibit startup message