local ok, nvim_treesitter_config = pcall(require, 'nvim-treesitter.configs')

if not ok then
  return
end

nvim_treesitter_config.setup {
  ensure_installed = {
    'bash',
    'bibtex',
    'c',
    'clojure',
    'comment',
    'commonlisp',
    'cpp',
    'c_sharp',
    'css',
    'diff',
    'dockerfile',
    'fennel',
    'gitignore',
    'go',
    'html',
    'http',
    'java',
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

    -- WARNING: C# treesitter makes launching nvim slow, IDKW
    -- disable = { 'c_sharp' },

    -- NOTE: Disable treesitter for large file sizes
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local file_ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if file_ok and stats and stats.size > max_filesize then
        return true
      end
    end,
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
