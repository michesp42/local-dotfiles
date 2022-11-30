local map = vim.keymap.set

map('n', '<leader>vh', '<cmd>set hlsearch!<cr>', { desc = 'toggle highlighting search' })
map('v', '<leader>vv', '"_d', { desc = 'send the currently visually highlighted text to the void register' })
map('n', '<leader>wc', '<cmd>set spell!<cr>', { desc = 'Toggle spell checking' })

-- resizing
map('n', '<c-right>', '<cmd>vertical resize +3<cr>', { desc = 'resize split vertically to the right' })
map('n', '<c-left>', '<cmd>vertical resize -3<cr>', { desc = 'resize split vertically to the left' })
map('n', '<c-up>', '<cmd>horizontal resize +3<cr>', { desc = 'resize split horizontally upward' })
map('n', '<c-down>', '<cmd>horizontal resize -3<cr>', { desc = 'resize split horizontally downward' })

-- Telescope
map('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end, { desc = 'find files' })
map('n', '<leader>fz', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end, { desc = 'current buffer fuzzy find' })
map('n', '<leader>fo', function()
  require('telescope.builtin').oldfiles()
end, { desc = 'old files' })
map('n', '<leader>fg', function()
  require('telescope.builtin').live_grep()
end, { desc = 'live grep' })
map('n', '<leader>fb', function()
  require('telescope.builtin').buffers()
end, { desc = 'buffers' })
map('n', '<leader>fq', function()
  require('telescope.builtin').quickfix()
end, { desc = 'quickfix' })
map('n', '<leader>fl', function()
  require('telescope.builtin').loclist()
end, { desc = 'loclist' })
map('n', '<leader>fh', function()
  require('telescope.builtin').help_tags()
end, { desc = 'help tags' })
map('n', '<leader>fs', function()
  require('telescope.builtin').grep_string()
end, { desc = 'grep string' })
map('n', '<leader>fc', function()
  require('telescope.builtin').commands()
end, { desc = 'commands' })
map('n', '<leader>fm', function()
  require('telescope.builtin').man_pages()
end, { desc = 'man pages' })
map('n', '<leader>fv', function()
  require('telescope.builtin').vim_options()
end, { desc = 'vim options' })
map('n', '<leader>fp', function()
  require('telescope.builtin').planets()
end, { desc = 'planets' })
map('n', '<leader>ft', function()
  require('telescope.builtin').treesitter()
end, { desc = 'treesitter' })
map('n', '<leader>fr', function()
  require('telescope.builtin').reloader()
end, { desc = 'reloader' })

-- custom functions
map('n', '<leader>fn', function()
  require('config.custom.telescope').search_nvimrc()
end, { desc = 'find files in neovim config directory' })

-- nvim-highlight-colors
map('n', '<leader>xe', function()
  require('nvim-highlight-colors').turnOn()
end, { desc = 'Turn on color highlighting' })
map('n', '<leader>xd', function()
  require('nvim-highlight-colors').turnOff()
end, { desc = 'Turn off color highlighting' })
map('n', '<leader>xt', function()
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

-- autoformatter keymaps
map('n', '<leader>bf', '<cmd>Format<cr>', { desc = 'autoformat buffer' })
map('n', '<leader>bw', '<cmd>FormatWrite<cr>', { desc = 'autoformat buffer and save file' })

-- NvimTree keymaps
map('n', '<leader>nt', '<cmd>NvimTreeToggle<cr>', { desc = 'toggle nvim-tree' })
map('n', '<leader>nf', '<cmd>NvimTreeFocus<cr>', { desc = 'open nvim-tree if it is closed, and the focus on it' })
map(
  'n',
  '<leader>ns',
  '<cmd>NvimTreeFindFile<cr>',
  { desc = 'move the cursor for the current buffer, opening folders if needed' }
)
map('n', '<leader>nc', '<cmd>NvimTreeCollapse<cr>', { desc = 'collapse nvim-tree recursively' })

-- Zen mode
map('n', '<leader>vz', '<cmd>ZenMode<cr>', { desc = 'Toggle zen mode' })
