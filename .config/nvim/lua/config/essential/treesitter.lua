local ok, nvim_treesitter_config = pcall(require, 'nvim-treesitter.configs')

if not ok then
  return
end

nvim_treesitter_config.setup {
  ensure_installed = {
    'bash',
    'bibtex',
    'c',
    'comment',
    'commonlisp',
    'cpp',
    'css',
    'dockerfile',
    'gitignore',
    'go',
    'html',
    'http',
    'javascript',
    'json',
    'julia',
    'latex',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'rasi',
    'regex',
    'rust',
    'sql',
    'sxhkdrc',
    'toml',
    'typescript',
    'vim',
    'yaml',
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },

  indent = {
    enable = true,
  },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,

    colors = {
      '#88c0d0',
      '#a3b38c',
      '#ebcb8b',
      '#81a1c1',
      '#b48ead',
      '#bf616a',
      '#5e81ac',
    },
  },

  context_commentstring = {
    enable = true,
  },

  autotag = {
    enable = true,
  },

  endwise = {
    enable = true,
  },
}
