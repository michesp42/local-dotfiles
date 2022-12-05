local ok, fterm = pcall(require, "FTerm")

if not ok then
  return
end

fterm.setup({
  border = "single",
  dimensions = {
    height = 0.4,
    width = 1.0,
    x = 0,
    y = 1.0,
  },
})
