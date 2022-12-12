local ok, kanagawa = pcall(require, "kanagawa")

if not ok then
  return
end

vim.opt.fillchars:append({
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┨',
    vertright = '┣',
    verthoriz = '╋',
})

kanagawa.setup({
  globalStatus = true,
})

vim.cmd "colorscheme kanagawa"
