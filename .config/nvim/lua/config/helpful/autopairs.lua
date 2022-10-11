local ok, autopairs = pcall(require, 'nvim-autopairs')

if not ok then
  return
end

autopairs.setup {
  disabled_in_macro = true,
}
