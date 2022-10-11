local ok, nvim_highlight_colors = pcall(require, 'nvim-highlight-colors')

if not ok then
  return
end

nvim_highlight_colors.setup {
  render = 'background',
  enable_tailwind = false,
}
