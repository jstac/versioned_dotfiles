-- configs for mason, mason-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"texlab", "lua_ls", "pyright"},
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

-- Python language server (using Neovim 0.11+ built-in API)
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      }
    }
  }
}

-- Enable the LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('texlab')
vim.lsp.enable('pyright')

-- NOTE: LSP keybindings are configured in lua/core/keymaps.lua


