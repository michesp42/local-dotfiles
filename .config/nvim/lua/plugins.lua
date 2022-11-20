local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer = require 'packer'
local packer_bootstrap = ensure_packer()

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- startup optimization
  use 'lewis6991/impatient.nvim'

  -- telescope: fuzzy finder and much more
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- telescope extensions
  -- use {'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim'}

  -- lsp
  use 'neovim/nvim-lspconfig'

  -- Eclipse JDT language server
  use 'mfussenegger/nvim-jdtls'

  -- linting to complement lsp
  use 'mfussenegger/nvim-lint'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- completion
  use 'hrsh7th/nvim-cmp'

  -- completion sources
  use 'hrsh7th/cmp-nvim-lsp' -- lsp
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path' -- filesystem path
  use 'hrsh7th/cmp-cmdline' -- command line
  use 'hrsh7th/cmp-nvim-lua' -- completions from lua?
  use 'saadparwaiz1/cmp_luasnip' -- snippets (luasnip)
  use 'lukas-reineke/cmp-rg' -- ripgrep

  -- icons for completion candidates
  use 'onsails/lspkind.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter' }

  -- treesitter extensions
  use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'kylechui/nvim-surround', requires = 'nvim-treesitter/nvim-treesitter' }

  -- autopairing (brackets, parentheses, html tags, keywords like if ... fi)
  use { 'windwp/nvim-autopairs', requires = { 'nvim-treesitter/nvim-treesitter', opt = true } }
  use { 'windwp/nvim-ts-autotag', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'RRethy/nvim-treesitter-endwise', requires = 'nvim-treesitter/nvim-treesitter' }

  -- colorscheme
  use 'andersevenrud/nordic.nvim'

  -- visualizing undo history
  use 'mbbill/undotree'

  -- commenting
  use 'numToStr/Comment.nvim'

  -- terminal
  use 'numToStr/FTerm.nvim'

  -- autoformatter
  use 'mhartington/formatter.nvim'

  -- visual guide for keybindings
  use 'folke/which-key.nvim'

  -- git plugins
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- color highlighting
  use 'brenoprata10/nvim-highlight-colors'

  -- statusline plugin
  -- use 'rebelot/heirline.nvim'
  use 'nvim-lualine/lualine.nvim'

  -- icons
  use 'nvim-tree/nvim-web-devicons'

  -- file explorer
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }

  -- highlight todo comments
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- distraction-free writing
  use 'folke/zen-mode.nvim'
  use 'folke/twilight.nvim'

  -- indentation guides
  use 'lukas-reineke/indent-blankline.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
