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

vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#bf616a" })
vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#ebcb8b" })
vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = "#81a1c1" })
vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#a3b38c" })
vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#8fbcbb" })
vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#d08770" })
vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#b48ead" })
