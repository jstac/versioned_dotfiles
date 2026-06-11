-- WORKAROUND for a Neovim core memory leak (traced 2026-06-11).
--
-- vim/diagnostic/_store.lua:once_buf_loaded() registers a fresh, ungrouped
-- BufRead autocmd EVERY time diagnostics are set for an *unloaded* buffer, with
-- no dedup. Project-wide LSPs republish diagnostics for many unloaded files on
-- every edit — texlab over a multi-file paper (the opt_at_point project has 27
-- .tex files), and pyright with diagnosticMode='workspace'. Those closures pile
-- up in the Lua registry and never free, leaking ~10GB over a long session
-- until nvim exhausts RAM and the whole machine thrashes swap.
--
-- We never display diagnostics for buffers that aren't loaded, so just drop
-- them before they reach the leaking path. Diagnostics for files you actually
-- open still work (the server republishes on didOpen once the buffer loads).
-- Remove this once the upstream bug is fixed and we rebuild nvim.
do
  local orig_set = vim.diagnostic.set
  vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
    if type(bufnr) == 'number' and bufnr > 0 and not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end
    return orig_set(namespace, bufnr, diagnostics, opts)
  end
end

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

