local ok, ls = pcall(require, 'luasnip')

if not ok then
  return
end

require('luasnip.loaders.from_vscode').load()

ls.config.set_config {
  history = true,
  updateevents = 'TextChanged, TextChangedI',
  enable_autosnippets = true,
}
