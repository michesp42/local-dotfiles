local ok, lspconfig = pcall(require, "lspconfig")

if not ok then
  return
end

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<space>e", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", vim.lsp.buf.declaration, bufopts)
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gi", vim.lsp.buf.implementation, bufopts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  map("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  map("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  map("n", "gr", vim.lsp.buf.references, bufopts)
end

local servers = {
  "bashls",
  "clangd",
  "clojure_lsp",
  "cssls",
  "gopls",
  "html",
  "jedi_language_server",
  "jsonls",
  -- 'julials',
  "rust_analyzer",
  "texlab",
  "tsserver",
  "vimls",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.omnisharp.setup({
  cmd = {
    "dotnet",
    "/home/mice/.vscode-oss/extensions/ms-dotnettools.csharp-1.25.2-linux-x64/.omnisharp/1.39.2-net6.0/OmniSharp.dll",
  },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
})

-- TODO: setup arduino language server with AVR board specific stuff ...
-- TODO: when I finally have to use it
-- lspconfig.arduino_language_server.setup {
--   cmd = {
--     'arduino-language-server',
--     '-cli-config', '/path/to/arduino-cli.yaml',
--     '-fqbn', 'arduino:avr:uno',
--     '-cli', 'arduino-cli',
--     '-clangd', 'clangd'
--   }
-- }

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})
