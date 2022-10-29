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

-- TODO: temporary keymaps for telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>fs', '<cmd>Telescope grep_string<cr>')
map('n', '<leader>fc', '<cmd>Telescope command<cr>')
map('n', '<leader>fm', '<cmd>Telescope man_pages<cr>')
map('n', '<leader>fv', '<cmd>Telescope vim_options<cr>')
map('n', '<leader>fp', '<cmd>Telescope planets<cr>')
map('n', '<leader>ft', '<cmd>Telescope treesitter<cr>')
map('n', '<leader>fr', '<cmd>Telescope reloader<cr>')

-- TODO:
map('n', '<leader>ce', "<cmd>lua require('nvim-highlight-colors').turnOff()<cr>")
map('n', '<leader>cd', "<cmd>lua require('nvim-highlight-colors').turnOn()<cr>")
map('n', '<leader>ct', "<cmd>lua require('nvim-highlight-colors').toggle()<cr>")

-- fterm (builtin terminal plugin)
map('n', '<A-i>', '<cmd>lua require "FTerm".toggle()<cr>')
map('t', '<A-i>', '<C-\\><C-n><cmd>lua require "FTerm".toggle()<cr>')
map('t', '<A-e>', '<cmd>lua require "FTerm".exit()<cr>')

-- custom functions
map('n', '<leader>sn', '<cmd>lua require "config.custom.telescope".search_nvimrc()<cr>')

-- autoformatter keymaps
map('n', '<leader>bf', '<cmd>Format<cr>')
map('n', '<leader>bw', '<cmd>FormatWrite<cr>')
