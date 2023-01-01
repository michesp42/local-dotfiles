local ok, nord = pcall(require, "nord")

if not ok then
  return
end

nord.setup({
  styles = {
    keywords = { italic = true },
  },
  errors = { mode = "fg" },
})

vim.cmd("colorscheme nord")
