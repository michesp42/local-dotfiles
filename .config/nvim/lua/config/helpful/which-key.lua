local ok, wk = pcall(require, "which-key")

if not ok then
  return
end

wk.setup({})

wk.register({
  ["<leader>t"] = { name = "+telescope" },
  ["<leader>v"] = { name = "+visual stuff" },
  ["<leader>x"] = { name = "+colors highlighting" },
  ["<leader>f"] = { name = "+formatter" },
  ["<leader>n"] = { name = "+nvim-tree" },
})
