-- configs for mason, mason-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"texlab", "lua_ls"},
})

-- Enable nvim-cmp LSP completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua language server (using Neovim 0.11+ built-in API)
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = {'vim'} },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    }
  }
}

-- LaTeX language server (using Neovim 0.11+ built-in API)
vim.lsp.config.texlab = {
  cmd = { 'texlab' },
  root_markers = { '.latexmkrc', '.git' },
  capabilities = capabilities,
}

-- Enable the LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('texlab')

-- LSP keybindings (set on attach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})


