local ok, indent_blankline = pcall(require, 'indent_blankline')

if not ok then
  return
end

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_use_treesitter_scope = true
vim.g.indent_blankline_max_indent_increase = 1

indent_blankline.setup {}
