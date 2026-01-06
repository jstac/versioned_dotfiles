-- # Keymaps
--
-- ALL keymaps are centralized here for easy reference and conflict checking.
-- Plugin configs contain only setup code, not keybindings.

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

-- Exit insert mode quickly (alternative to Esc)
-- Usage: Type 'jj' quickly in insert mode to return to normal mode
vim.keymap.set('i', "jj", "<Esc>", opts)

-- Format/reflow paragraph to textwidth (80 chars by default)
-- Usage: In normal mode, press Q to reformat the current paragraph
vim.keymap.set('n', 'Q', '{gq}', opts)

-- Navigate to next buffer in buffer list
-- Usage: Ctrl-n to cycle through open buffers
vim.keymap.set('n', '<C-n>', ':bnext<CR>', opts)

-- Exit terminal mode to normal mode
-- Usage: In terminal, press Ctrl-\ twice to get back to normal mode
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>', opts)

-- Navigate between vim splits from terminal mode
-- These allow Ctrl-h/l navigation even when cursor is in a terminal split
-- Works seamlessly with tmux pane navigation via vim-tmux-navigator
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w><C-l>', opts)  -- Move right
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w><C-h>', opts)  -- Move left


----- Leader maps ------

-- Set leader key to Space and local leader to backslash
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Save current file
-- Usage: Space-w to write/save
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)

-- Delete/close current buffer
-- Usage: Space-d to close buffer
vim.keymap.set('n', '<leader>d', ':bd<CR>', opts)

-- Reload Neovim configuration
-- Usage: Space-Enter to reload init.lua (useful after config changes)
vim.api.nvim_set_keymap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", opts)

-- Toggle spell checking on/off
-- Usage: Space-st to enable/disable spell checking (US English)
vim.keymap.set('n', '<leader>st',':setlocal spell! spelllang=en_us<CR>', opts)


----- Plugin-specific keymaps ----
--
-- All plugin keymaps centralized here for easy reference and conflict checking


-- === ToggleTerm - Terminal Management ===
-- Prefix: 'a' = add terminal, 's' = send to terminal

-- Open terminal in vertical split (68 columns wide, on right side)
vim.keymap.set('n', '<leader>av', ':ToggleTerm size=68 direction=vertical<CR>', opts)

-- Open terminal in horizontal split (8 rows tall, at bottom)
vim.keymap.set('n', '<leader>ah', ':ToggleTerm size=8 direction=horizontal<CR>', opts)

-- Open terminal in floating window
vim.keymap.set('n', '<leader>af', ':ToggleTerm direction=float<CR>', opts)

-- Send current line to terminal (useful for REPL workflows)
vim.keymap.set('n', '<leader>sl', ':ToggleTermSendCurrentLine<CR>', opts)

-- Send visual selection to terminal (useful for running code blocks)
vim.keymap.set('v', '<leader>ss', ":'<,'>ToggleTermSendVisualLines<CR>", opts)


-- === Telescope - Fuzzy Finder ===
-- Prefix: 'f' = find

-- Find files by name (respects .gitignore)
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')

-- Live grep - search text content across all files
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')

-- Browse open buffers
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')

-- Search help documentation
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>')


-- === Oil - File Explorer ===

-- Open parent directory in current window (edit filesystem like a buffer)
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", function() require("oil").toggle_float() end, { desc = "Open parent directory in floating window" })


-- === Flash - Fast Motion ===
-- Jump to any visible location with minimal keystrokes

-- Jump by 2-character search (most common usage)
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })

-- Jump by treesitter node (semantic jumping - functions, classes, etc.)
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash treesitter" })

-- Remote Flash: use Flash in operator-pending mode to operate on distant text
-- Example: d + r + <search> to delete to a distant location
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })

-- Treesitter search: search and select treesitter nodes in operator-pending mode
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter search" })


-- === LSP - Language Server Protocol ===
-- These keybindings are automatically set when an LSP attaches to a buffer
-- (e.g., when you open a Python file with pyright installed)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local buf_opts = { buffer = ev.buf }

    -- Jump to where symbol is defined
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)

    -- Jump to where symbol is declared (e.g., function prototype in C)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)

    -- Show documentation/signature for symbol under cursor
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)

    -- Jump to implementation (e.g., from interface to concrete class)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)

    -- Show all references to symbol under cursor
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)

    -- Rename symbol across entire project
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buf_opts)

    -- Show available code actions (e.g., quick fixes, refactorings)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, buf_opts)

    -- Show diagnostic error/warning details in floating window
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, buf_opts)
  end,
})

