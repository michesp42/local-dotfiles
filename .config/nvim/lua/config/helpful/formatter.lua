local ok, formatter = pcall(require, 'formatter')

if not ok then
  return
end

local function myclangformat()
  return function()
    return {
      exe = 'clang-format',
      args = {
        '-style="{BasedOnStyle: chromium, IndentWidth: 4}"',
        '--assume-filename',
        vim.api.nvim_buf_get_name(0),
      },
      stdin = true,
      cwd = vim.fn.expand '%:p:h',
    }
  end
end

local formatterConfig = {
  arduino = { myclangformat() },
  c = { myclangformat() },
  cpp = { myclangformat() },
  java = { myclangformat() },

  rust = {
    function()
      return { exe = 'rustfmt', args = { '--emit=stdout' }, stdin = true }
    end,
  },

  sh = {
    function()
      return { exe = 'shfmt', args = { '-i', 2 }, stdin = true }
    end,
  },

  lua = {
    function()
      return {
        exe = 'stylua',
        args = { '-f ~/.config/stylua/stylua.toml -' },
        stdin = true,
      }
    end,
  },

  python = {
    function()
      return { exe = 'black', args = { '-l 79 -' }, stdin = true }
    end,
  },

  -- tex = {
  --   function()
  --     return { exe = "latexindent", stdin = true }
  --   end,
  -- },

  -- haskell = {
  --   function()
  --     return { exe = "ormolu", stdin = true }
  --   end,
  -- },

  -- toml = {
  --   function()
  --     return { exe = "taplo", args = { "fmt -" }, stdin = true }
  --   end,
  -- },

  go = {
    function()
      return {
        exe = 'gofmt',
        args = { vim.api.nvim_buf_get_name(0) },
        stdin = true,
      }
    end,
  },

  -- fortran = {
  --   function()
  --     return {
  --       exe = "fprettify",
  --       args = {
  --         "--silent --indent 2",
  --         vim.api.nvim_buf_get_name(0),
  --       },
  --       stdin = true,
  --     }
  --   end,
  -- },
}

local prettierConfig = function()
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

local commonFT = {
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

-- set prettier as formatter for common filetypes above
for _, ft in ipairs(commonFT) do
  formatterConfig[ft] = { prettierConfig }
end

formatter.setup { logging = false, filetype = formatterConfig }
