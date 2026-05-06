-- Completion via blink.cmp.
--
-- Sources (in order of preference):
--   lsp       — texlab / pyright / lua_ls suggestions
--   snippets  — LuaSnip-managed snipmate files in ~/.config/nvim/snippets
--   buffer    — words drawn from open buffers (the prose workhorse)
--   path      — filesystem paths after "/" or "./"
--
-- Tab cycles popup items, then falls through to snippet jump, then literal Tab.
-- Enter accepts only an explicitly-selected item (auto_insert = false), so it
-- never silently commits a suggestion while writing prose.

require('luasnip.loaders.from_snipmate').load({
  paths = vim.fn.stdpath('config') .. '/snippets',
})

require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<Tab>']     = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>']   = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<CR>']      = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>']     = { 'hide', 'fallback' },
  },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'snippets', 'buffer', 'path' },
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },
})
