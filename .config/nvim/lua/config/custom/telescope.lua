local M = {}
M.search_nvimrc = function()
  require("telescope.builtin").find_files({
    prompt_title = "< NVIMRC > ",
    cwd = "~/.config/nvim/",
  })
end

-- M.search_dotfiles = function()
--   require("telescope.builtin").find_files({
--     prompt_title = "< DOTFILES > ",
--     cwd = "~/.local/share/dotfiles/",
--   })
-- end

return M
