-- Mason: install/manage external LSP servers (and any other tools we add
-- later — formatters, linters, DAP). mason-tool-installer reconciles the
-- ensure_installed list against what's actually present on disk.
--
-- NOTE: names here are *mason package names* (see :Mason), not lspconfig
-- server names. They mostly match, but a few differ — e.g. lspconfig's
-- "lua_ls" is mason's "lua-language-server".
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = { "texlab", "lua-language-server", "pyright" },
})

-- Advertise blink.cmp's completion capabilities to every server. The '*'
-- entry merges into each server's per-name config below.
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Lua language server (using Neovim 0.11+ built-in API)
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
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
}

-- Python language server (using Neovim 0.11+ built-in API)
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
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
-- NOTE: Completion popup is driven by blink.cmp (see plugin_config/completion.lua)

