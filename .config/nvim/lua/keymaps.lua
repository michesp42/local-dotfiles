local map = vim.keymap.set

-- toggle highlighting when searching in buffer
map('n', '<leader>vh', '<cmd>set hlsearch!<cr>')

-- resizing splits
map('n', '<c-right>', '<cmd>vertical resize +3<cr>')
map('n', '<c-left>', '<cmd>vertical resize -3<cr>')
map('n', '<c-up>', '<cmd>horizontal resize +3<cr>')
map('n', '<c-down>', '<cmd>horizontal resize +3<cr>')

-- send the currently visually highlighted text to the void register
map('v', '<leader>vv', '"_d')

-- most used to highlight whole functions
map('v', '<leader>vp', 'Vf{%')

-- Toggle spell checking
map('n', '<leader>wc', '<cmd>set spell!<cr>')

-- Telescope
map('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end)
map('n', '<leader>fz', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end)
map('n', '<leader>fo', function()
  require('telescope.builtin').oldfiles()
end)
map('n', '<leader>fg', function()
  require('telescope.builtin').live_grep()
end)
map('n', '<leader>fb', function()
  require('telescope.builtin').buffers()
end)
map('n', '<leader>fq', function()
  require('telescope.builtin').quickfix()
end)
map('n', '<leader>fl', function()
  require('telescope.builtin').loclist()
end)
map('n', '<leader>fh', function()
  require('telescope.builtin').help_tags()
end)
map('n', '<leader>fs', function()
  require('telescope.builtin').grep_string()
end)
map('n', '<leader>fc', function()
  require('telescope.builtin').commands()
end)
map('n', '<leader>fm', function()
  require('telescope.builtin').man_pages()
end)
map('n', '<leader>fv', function()
  require('telescope.builtin').vim_options()
end)
map('n', '<leader>fp', function()
  require('telescope.builtin').planets()
end)
map('n', '<leader>ft', function()
  require('telescope.builtin').treesitter()
end)
map('n', '<leader>fr', function()
  require('telescope.builtin').reloader()
end)

-- nvim-highlight-colors
map('n', '<leader>ce', function()
  require('nvim-highlight-colors').turnOn()
end, { desc = 'Turn on color highlighting' })
map('n', '<leader>cd', function()
  require('nvim-highlight-colors').turnOff()
end, { desc = 'Turn off color highlighting' })
map('n', '<leader>ct', function()
  require('nvim-highlight-colors').toggle()
end, { desc = 'Toggle color highlighting' })

-- fterm (builtin terminal plugin)
map('n', '<A-i>', function()
  require('FTerm').toggle()
end, { desc = '[FTerm] Toggle terminal' })
map('t', '<A-i>', function()
  require('FTerm').toggle()
end, { desc = '[FTerm] Toggle terminal' })
map('t', '<A-e>', function()
  require('FTerm').exit()
end, { desc = '[FTerm] Exit terminal' })

-- custom functions
map('n', '<leader>sn', function()
  require('config.custom.telescope').search_nvimrc()
end, { desc = '[Telescope] find files in neovim config directory' })

-- autoformatter keymaps
map('n', '<leader>bf', '<cmd>Format<cr>')
map('n', '<leader>bw', '<cmd>FormatWrite<cr>')
