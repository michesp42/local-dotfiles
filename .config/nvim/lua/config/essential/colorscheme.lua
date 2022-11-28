local ok, onedark = pcall(require, 'onedark')

if not ok then
  return
end

onedark.setup {
  code_style = {
    keywords = 'italic',
  },

  highlights = {
    MatchParen = { fg = '#ff6c6b', bg = '#22252A' },
  },
}

onedark.load()
