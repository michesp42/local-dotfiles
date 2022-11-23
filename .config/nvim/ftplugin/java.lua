if vim.g.vscode then
  return
end

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<space>q', vim.diagnostic.setloclist, opts)

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', vim.lsp.buf.definition, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  map('n', 'gr', vim.lsp.buf.references, bufopts)

  -- jdtls remaps
  map('n', '<leader>ji', function()
    require('jdtls').organize_imports()
  end, bufopts)
  map('n', '<leader>jv', function()
    require('jdtls').extract_variable()
  end, bufopts)
  map('v', '<leader>jv', function()
    require('jdtls').extract_variable(true)
  end, bufopts)
  map('n', '<leader>jc', function()
    require('jdtls').extract_constant()
  end, bufopts)
  map('v', '<leader>jc', function()
    require('jdtls').extract_constant(true)
  end, bufopts)
  map('v', '<leader>jm', function()
    require('jdtls').extract_method(true)
  end, bufopts)
end

local config = {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({
    '.gradlew',
    '.git',
    'mvnw',
  }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
