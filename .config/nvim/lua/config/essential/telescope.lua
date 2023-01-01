local ok, telescope = pcall(require, "telescope")

if not ok then
  return
end

telescope.setup({
  defaults = {
    preview = {
      msg_bg_fillchar = " ",
    },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },
})
