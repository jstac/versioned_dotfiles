-- # Keymaps


-- ## List of modes
--
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',


-- ## Set up

local opts = { noremap = true, silent = true }

-- ## Leader

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"



-- ## General maps (not plugin related) 

---- normal mode maps ----

-- basic leader maps
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
vim.keymap.set('n', '<leader>d', ':bd<CR>', opts)
-- split motion
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)
-- buffer motion
vim.keymap.set('n', '<C-n>', ':bnext<CR>', opts)
-- working with text
vim.keymap.set('n', 'Q', '{gq}', opts)


---- insert mode maps ----

-- split motion
vim.keymap.set('i', '<A-h>', '<ESC><C-w>h', opts)
vim.keymap.set('i', '<A-j>', '<ESC><C-w>j', opts)
vim.keymap.set('i', '<A-k>', '<ESC><C-w>k', opts)
vim.keymap.set('i', '<A-l>', '<ESC><C-w>l', opts)

---- visual mode maps ----



---- terminal mode maps ----

-- split motion
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h', opts)
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j', opts)
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k', opts)
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l', opts)


-- ## Plugin specific maps  

-- Telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', opts)
-- ToggleTerm
vim.keymap.set('n', '<leader>tv', ':ToggleTerm size=72 direction=vertical<CR>', opts)
vim.keymap.set('n', '<leader>th', ':ToggleTerm size=12 direction=horizontal<CR>', opts)
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', opts)
vim.keymap.set('n', '<leader>tl', ':ToggleTermSendCurrentLine<CR>', opts)
vim.keymap.set('v', '<leader>ts', ":'<,'>ToggleTermSendVisualLines<CR>", opts)


