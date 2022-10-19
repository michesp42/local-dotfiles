local zen_ok, zen = pcall(require, 'zen-mode')

if not zen_ok then
  return
end

local twilight_ok, twilight = pcall(require, 'twilight')

if not twilight_ok then
  return
end

zen.setup {
  window = {
    backdrop = 0.85,
    options = {
      colorcolumn = '0',
      cursorcolumn = false,
      cursorline = false,
      foldcolumn = '0',
      list = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
    },
  },
  plugins = {
    twilight = { enabled = true },
  },
}

twilight.setup()
