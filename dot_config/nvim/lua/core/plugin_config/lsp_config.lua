-- configs for mason, mason-lspconfig, lspconfig
require("mason").setup()
require("mason-lspconfig").setup()

-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- servers

require("mason-lspconfig").setup({
    ensure_installed = {"texlab", "lua_ls"},
})

-- individual server configs

-- lua
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = {'vim'} },
    }
  }
}

-- latex
vim.lsp.config.texlab = {
  cmd = { 'texlab' },
}


