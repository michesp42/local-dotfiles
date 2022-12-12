local ok, nvim_treesitter_config = pcall(require, "nvim-treesitter.configs")

if not ok then
  return
end

nvim_treesitter_config.setup({
  ensure_installed = {
    "arduino",
    "awk",
    "bash",
    "bibtex",
    "c",
    "clojure",
    "comment",
    "commonlisp",
    "cmake",
    "cpp",
    "c_sharp",
    "css",
    "diff",
    "dockerfile",
    "elm",
    "fennel",
    "gitignore",
    "go",
    "gomod",
    "haskell",
    "html",
    "http",
    "java",
    "javascript",
    "json",
    "julia",
    "latex",
    "lua",
    "org",
    "make",
    "markdown",
    "markdown_inline",
    "php",
    "phpdoc",
    "python",
    "racket",
    "rasi",
    "regex",
    "ruby",
    "rust",
    "sql",
    "sxhkdrc",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,

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
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
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
      "#6a9589",
      "#98bb6c",
      "#dca561",
      "#a3d4d5",
      "#957fb8",
      "#e46876",
      "#7e9cd8",
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
})
