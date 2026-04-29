-- nvim-treesitter main branch setup.
-- The legacy nvim-treesitter.configs API is gone. Highlighting, folds,
-- and indent are now driven by Neovim core via vim.treesitter.* and
-- enabled per-filetype below. The plugin's role is reduced to parser
-- install/update plus query distribution.

require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Parsers we want available. install() is async by default and a no-op
-- if a parser is already present.
require('nvim-treesitter').install({
  'c', 'lua', 'python', 'rust', 'ruby', 'vim',
  'latex', 'markdown', 'markdown_inline',
})

-- Enable treesitter highlighting for any filetype that has a parser.
-- pcall keeps unrelated filetypes (or transient errors during :TSUpdate)
-- from breaking buffer load.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
