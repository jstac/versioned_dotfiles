-- # Keymaps

-- Note that plugin-specific maps are in plugin_config

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


-- ## General maps (not plugin related) 

-- set leader and local leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- working with text
vim.keymap.set('n', 'Q', '{gq}', opts)

-- motion across splits (alt h,j,k,l works in any mode)
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)
vim.keymap.set('i', '<A-h>', '<ESC><C-w>h', opts)
vim.keymap.set('i', '<A-j>', '<ESC><C-w>j', opts)
vim.keymap.set('i', '<A-k>', '<ESC><C-w>k', opts)
vim.keymap.set('i', '<A-l>', '<ESC><C-w>l', opts)
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h', opts)
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j', opts)
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k', opts)
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l', opts)

-- buffer motion
--vim.keymap.set('n', '<C-n>', ':bnext<CR>', opts)
vim.keymap.set('n', '<C-n>', ':bnext<CR>', opts)

-- terminal escape
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>', opts)


----- leader maps ------

-- basic editing
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
vim.keymap.set('n', '<leader>d', ':bd<CR>', opts)

-- reload
vim.api.nvim_set_keymap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", opts)

-- toggle spelling
vim.keymap.set('n', '<leader>st',':setlocal spell! spelllang=en_us<CR>', opts)


----- Plugin-specific keymaps ----
--
-- (keep here so they don't clash) ---


-- ToggleTerm keymaps (s stands for 'send', a stands for 'add')
vim.keymap.set('n', '<leader>av', ':ToggleTerm size=72 direction=vertical<CR>', opts)
vim.keymap.set('n', '<leader>ah', ':ToggleTerm size=8 direction=horizontal<CR>', opts)
vim.keymap.set('n', '<leader>af', ':ToggleTerm direction=float<CR>', opts)
vim.keymap.set('n', '<leader>sl', ':ToggleTermSendCurrentLine<CR>', opts)
vim.keymap.set('v', '<leader>ss', ":'<,'>ToggleTermSendVisualLines<CR>", opts)


-- fzf-lua keymaps
vim.keymap.set('n', '<leader>f', ':FzfLua files<CR>', opts)

-- nvim-tree keymaps
vim.keymap.set('n', '<leader>t', ':NvimTreeFindFileToggle<CR>')