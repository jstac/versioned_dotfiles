require("toggleterm").setup {}


-- ToggleTerm keymaps
--
vim.keymap.set('n', '<leader>tv', ':ToggleTerm size=72 direction=vertical<CR>', opts)
vim.keymap.set('n', '<leader>th', ':ToggleTerm size=8 direction=horizontal<CR>', opts)
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', opts)
vim.keymap.set('n', '<leader>tl', ':ToggleTermSendCurrentLine<CR>', opts)
vim.keymap.set('v', '<leader>ts', ":'<,'>ToggleTermSendVisualLines<CR>", opts)


