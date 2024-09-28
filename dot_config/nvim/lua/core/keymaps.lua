-- # Keymaps

-- Note that plugin-specific maps are in plugin_config

-- ## List of modes
--
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   select_mode = 's',   (similar to visual_mode)
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',


-- ## Set up

local opts = { noremap = true, silent = true }


-- ## General maps (not plugin related) 

-- jj to escape in insert model
vim.keymap.set('i', "jj", "<Esc>", opts)

-- working with text
vim.keymap.set('n', 'Q', '{gq}', opts)

-- buffer motion
--vim.keymap.set('n', '<C-n>', ':bnext<CR>', opts)
vim.keymap.set('n', '<C-n>', ':bnext<CR>', opts)

-- terminal escape
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>', opts)

-- Terminal motion across splits.  These motions allow for C-l, C-h type motions
-- even when in terminal mode in a given split.  They coincide with similar
-- motions for other modes (and in tmux) implemented by 'christoomey/vim-tmux-navigator'.
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w><C-l>', opts)
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w><C-h>', opts)


----- Leader maps ------

-- set leader and local leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
-- vim.keymap.set('n', '<leader>f', ':FzfLua files<CR>', opts)

-- telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>')

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- telescope-cmdline extension --- always cmdline when typing :
vim.api.nvim_set_keymap('n', ':', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
-- alternative below
--vim.api.nvim_set_keymap('n', '<leader><leader>', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
