local ok, nordic = pcall(require, 'nordic')

if not ok then
  return
end

nordic.colorscheme {
  underline_option = 'underline',
  italic = false,
  italic_comments = true,
  minimal_mode = false,
  alternate_backgrounds = true,
}

-- custom syntax highlight
vim.api.nvim_set_hl(0, 'TSFunction', { fg = '#88c0d0' })
vim.api.nvim_set_hl(0, 'TSMethod', { fg = '#88c0d0' })
vim.api.nvim_set_hl(0, 'TSConstructor', { fg = '#ebcb8b' })

-- custom highlights for nvim-cmp
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#373e4d', fg = 'NONE' })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#2b303b' })

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#88c0d0', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#88c0d0', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#b48ead', bg = 'NONE' })

vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#EED8DA', bg = '#bf616a' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#EED8DA', bg = '#bf616a' })
vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#EED8DA', bg = '#bf616a' })

vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#C3E88D', bg = '#a3be8c' })
vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#C3E88D', bg = '#a3be8c' })
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#C3E88D', bg = '#a3be8c' })

vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })

vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#EADFF0', bg = '#b48ead' })
vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#EADFF0', bg = '#b48ead' })
vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#EADFF0', bg = '#b48ead' })
vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#EADFF0', bg = '#b48ead' })
vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#EADFF0', bg = '#b48ead' })

vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })

vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })

vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#DDE5F5', bg = '#81a1c1' })
vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#DDE5F5', bg = '#81a1c1' })
vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#81a1c1' })

vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#D8EEEB', bg = '#8fbcbb' })
vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D8EEEB', bg = '#8fbcbb' })
vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#8fbcbb' })
