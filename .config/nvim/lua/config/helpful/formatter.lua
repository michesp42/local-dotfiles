local ok, formatter = pcall(require, 'formatter')

if not ok then
  return
end

local formatter_config = {
  fennel = {
    function()
      return {
        exe = 'fnlfmt',
        args = { vim.api.nvim_buf_get_name(0) },
        stdin = true,
      }
    end,
  },

  go = {
    require('formatter.filetypes.go').gofmt(),
  },

  java = {
    function()
      return {
        exe = 'clang-format',
        args = {
          '--style=google',
          '--assume-filename',
          vim.api.nvim_buf_get_name(0),
        },
        stdin = true,
      }
    end,
  },

  lua = {
    require('formatter.filetypes.lua').stylua,
  },

  python = {
    require('formatter.filetypes.python').black(),
  },

  rust = {
    require('formatter.filetypes.rust').rustfmt(),
  },

  sh = {
    function()
      return {
        exe = 'shfmt',
        args = { '-i', 2 },
        stdin = true,
      }
    end,
  },

  tex = {
    require('formatter.filetypes.latex').latexindent(),
  },

  toml = {
    require('formatter.filetypes.toml').taplo(),
  },

  ['*'] = {
    require('formatter.filetypes.any').remove_trailing_whitespace,
  },
}

local my_clangformat = function()
  return {
    exe = 'clang-format',
    args = {
      '-style="{BasedOnStyle: google, IndentWidth: 4, AccessModifierOffset: -4}"',
      '--assume-filename',
      vim.api.nvim_buf_get_name(0),
    },
    stdin = true,
    cwd = vim.fn.expand '%:p:h',
  }
end

local c_like_ft = {
  'arduino',
  'c',
  'cpp',
}

for _, ft in ipairs(c_like_ft) do
  formatter_config[ft] = { my_clangformat }
end

local prettier_config = function()
  return {
    exe = 'prettier',
    args = {
      '--stdin-filepath',
      vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
      '--single-quote',
    },
    stdin = true,
  }
end

local prettier_supported_ft = {
  'css',
  'scss',
  'html',
  'javascript',
  'typescript',
  'typescriptreact',
  'markdown',
  'markdown.mdx',
  'json',
  'yaml',
}

-- set prettier as formatter for supported filetypes above
for _, ft in ipairs(prettier_supported_ft) do
  formatter_config[ft] = { prettier_config }
end

formatter.setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = formatter_config,
}
