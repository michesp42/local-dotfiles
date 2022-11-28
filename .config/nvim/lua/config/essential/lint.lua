local ok, lint = pcall(require, 'lint')

if not ok then
  return
end

-- lint.linters.clippy = {
--   cmd = 'cargo-clippy',
--   stdin = true,
--   args = {},
--   stream = 'both',
--   ignore_exitcode = false,
--   env = nil,
-- }

lint.linters_by_ft = {
  c = { 'clangtidy', 'cppcheck' },
  cpp = { 'clangtidy', 'cppcheck' },
  fennel = { 'fennel' },
  go = { 'golangcilint', 'revive' },
  java = { 'checkstyle' },
  javascript = { 'eslint' },
  lua = { 'luacheck' },
  python = { 'flake8', 'mypy', 'pycodestyle', 'pydocstyle', 'pylint' },
  -- rust = { 'clippy' },
  sh = { 'shellcheck' },
  tex = { 'lacheck' },
  vim = { 'vint' },
  yaml = { 'yamllint' },
}

-- luacheck: globals vim
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    lint.try_lint()
  end,
})
