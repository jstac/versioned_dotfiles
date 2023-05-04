-- configs for mason, mason-lspconfig, lspconfig
require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- servers

require("mason-lspconfig").setup({
    ensure_installed = {"texlab", "lua_ls"},
})

-- individual server configs

-- lua
require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}

-- latex
require("lspconfig").texlab.setup {}


