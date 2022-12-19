local map = function(mode)
  return function(keymap, command, opts)
    if not opts then
      vim.keymap.set(mode, keymap, command)
    else
      vim.keymap.set(mode, keymap, command, opts)
    end
  end
end

local nnoremap = map("n")
local vnoremap = map("v")
local tnoremap = map("t")
local xnoremap = map("x")

nnoremap("<leader>vh", "<cmd>set hlsearch!<cr>", { desc = "toggle highlighting search" })
xnoremap("<leader>vv", '"_d', { desc = "send the currently visually highlighted text to the void register" })
nnoremap("<leader>wc", "<cmd>set spell!<cr>", { desc = "Toggle spell checking" })

-- Moving highlighted text around
-- TODO: How make this keymap to be prefixable by a number like "7J"
vnoremap("<c-j>", ":m '>+1<cr>gv=gv", { desc = "move highligted text up" })
vnoremap("<c-k>", ":m '<-2<cr>gv=gv", { desc = "move highligted text down" })

-- Make the cursor stay in the middle so as not to make me disoriented when text moves around in Neovim
nnoremap("<C-d>", "<C-d>zz", { desc = "same as <C-d> but cursor stays in the middle of the screen" })
nnoremap("<C-u>", "<C-u>zz", { desc = "same as <C-u> but cursor stays in the middle of the screen" })
nnoremap("n", "nzzzv", { desc = "same as `n` but cursor stays in the middle of the screen" })
nnoremap("N", "Nzzzv", { desc = "same as `N` but cursor stays in the middle of the screen" })

-- Yanking text
nnoremap("<leader>y", '"+y', { desc = "yank text to system clipboard" })
vnoremap("<leader>y", '"+y', { desc = "yank text to system clipboard" })
nnoremap("<leader>Y", '"+Y', { desc = "yank text to system clipboard" })

-- quickfix/loclist navigation
nnoremap("<C-k>", "<cmd>cnext<CR>zz", { desc = "same as :cnext but cursor stays in the middle of the screen" })
nnoremap("<C-j>", "<cmd>cprev<CR>zz", { desc = "same as :cprev but cursor stays in the middle of the screen" })
nnoremap("<leader>k", "<cmd>lnext<CR>zz", { desc = "same as :lnext but cursor stays in the middle of the screen" })
nnoremap("<leader>j", "<cmd>lprev<CR>zz", { desc = "same as :lprev but cursor stays in the middle of the screen" })

nnoremap(
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "start replacing text at point" }
)
nnoremap("<leader>px", "<cmd>!chmod 744 %<CR>", { silent = true, desc = "make current file executable" })
nnoremap("<leader>pu", "<cmd>!chmod 644 %<CR>", { silent = true, desc = "make current file non-executable" })

-- resizing
nnoremap("<c-right>", "<cmd>vertical resize +3<cr>", { desc = "resize split vertically to the right" })
nnoremap("<c-left>", "<cmd>vertical resize -3<cr>", { desc = "resize split vertically to the left" })
nnoremap("<c-up>", "<cmd>horizontal resize +3<cr>", { desc = "resize split horizontally upward" })
nnoremap("<c-down>", "<cmd>horizontal resize -3<cr>", { desc = "resize split horizontally downward" })

-- Telescope
nnoremap("<leader>tf", function()
  require("telescope.builtin").find_files()
end, { desc = "find files" })
nnoremap("<leader>tz", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "current buffer fuzzy find" })
nnoremap("<leader>to", function()
  require("telescope.builtin").oldfiles()
end, { desc = "old files" })
nnoremap("<leader>tg", function()
  require("telescope.builtin").live_grep()
end, { desc = "live grep" })
nnoremap("<leader>tb", function()
  require("telescope.builtin").buffers()
end, { desc = "buffers" })
nnoremap("<leader>tq", function()
  require("telescope.builtin").quickfix()
end, { desc = "quickfix" })
nnoremap("<leader>tl", function()
  require("telescope.builtin").loclist()
end, { desc = "loclist" })
nnoremap("<leader>th", function()
  require("telescope.builtin").help_tags()
end, { desc = "help tags" })
nnoremap("<leader>ts", function()
  require("telescope.builtin").grep_string({
    search = vim.fn.input("grep > "),
  })
end, { desc = "grep string" })
nnoremap("<leader>tc", function()
  require("telescope.builtin").commands()
end, { desc = "commands" })
nnoremap("<leader>tm", function()
  require("telescope.builtin").man_pages()
end, { desc = "man pages" })
nnoremap("<leader>tv", function()
  require("telescope.builtin").vim_options()
end, { desc = "vim options" })
nnoremap("<leader>tp", function()
  require("telescope.builtin").planets()
end, { desc = "planets" })
nnoremap("<leader>tt", function()
  require("telescope.builtin").treesitter()
end, { desc = "treesitter" })
nnoremap("<leader>tr", function()
  require("telescope.builtin").reloader()
end, { desc = "reloader" })

-- custom functions
nnoremap("<leader>tn", function()
  require("config.custom.telescope").search_nvimrc()
end, { desc = "find files in neovim config directory" })

-- nvim-highlight-colors
nnoremap("<leader>xe", function()
  require("nvim-highlight-colors").turnOn()
end, { desc = "Turn on color highlighting" })
nnoremap("<leader>xd", function()
  require("nvim-highlight-colors").turnOff()
end, { desc = "Turn off color highlighting" })
nnoremap("<leader>xt", function()
  require("nvim-highlight-colors").toggle()
end, { desc = "Toggle color highlighting" })

-- fterm (builtin terminal plugin)
nnoremap("<A-i>", function()
  require("FTerm").toggle()
end, { desc = "[FTerm] Toggle terminal" })
tnoremap("<A-i>", function()
  require("FTerm").toggle()
end, { desc = "[FTerm] Toggle terminal" })
tnoremap("<A-e>", function()
  require("FTerm").exit()
end, { desc = "[FTerm] Exit terminal" })

-- autoformatter keymaps
nnoremap("<leader>ff", "<cmd>Format<cr>", { desc = "autoformat buffer" })
nnoremap("<leader>fw", "<cmd>FormatWrite<cr>", { desc = "autoformat buffer and save file" })

-- NvimTree keymaps
nnoremap("<leader>nt", "<cmd>NvimTreeToggle<cr>", { desc = "toggle nvim-tree" })
nnoremap("<leader>nf", "<cmd>NvimTreeFocus<cr>", { desc = "open nvim-tree if it is closed, and the focus on it" })
nnoremap(
  "<leader>ns",
  "<cmd>NvimTreeFindFile<cr>",
  { desc = "move the cursor for the current buffer, opening folders if needed" }
)
nnoremap("<leader>nc", "<cmd>NvimTreeCollapse<cr>", { desc = "collapse nvim-tree recursively" })

-- Zen mode
nnoremap("<leader>vz", "<cmd>ZenMode<cr>", { desc = "Toggle zen mode" })

-- Undo-tree
nnoremap("<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
