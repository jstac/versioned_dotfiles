--
-- This is from my failed attempt to use luasnip
--
-- To restart this effort, install that plugin, along with
--
-- jstac/luasnip-latex-snippets.nvim
--
-- and then uncomment the following code.
--
--
-- require'luasnip-latex-snippets'.setup()

-- require("luasnip").config.set_config({ -- Setting LuaSnip config
-- 
--   -- Enable autotriggered snippets
--   enable_autosnippets = false,
-- 
--   -- Use Tab (or some other key if you prefer) to trigger visual selection
--   store_selection_keys = "<Tab>",
-- })


-- require'luasnip-latex-snippets'.setup()

-- Eventually add more
--
-- require("luasnip.loaders.from_snipmate").lazy_load()

-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('i', '<Tab>', luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump', opts)

-- vim.cmd [[
-- imap <silent><expr> <C-i> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- ]]

